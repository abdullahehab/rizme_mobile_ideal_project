import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_ideal_project/config/helpers/assets_helper.dart';
import 'package:mobile_ideal_project/config/helpers/constants.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

final createPostProvider = ChangeNotifierProvider<CreatePostNotifier>((ref) {
  return CreatePostNotifier();
});

class CreatePostNotifier extends ChangeNotifier {
  final List<AssetEntity> _assets = [];
  List<AssetEntity> get assets => _assets;

  void remove(AssetEntity asset) {
    _assets.remove(asset);
    notifyListeners();
  }

  Future<void> pickPicturesFromGallery(BuildContext context) async {
    final List<AssetEntity>? pickedAssets = await AssetPicker.pickAssets(
      context,
    );

    if (pickedAssets == null || pickedAssets.isEmpty) return;

    final List<AssetEntity> validAssets = [];
    final List<AssetEntity> invalidAssets = [];

    // check for supportedExtensions
    for (final asset in pickedAssets) {
      final file = await asset.file;
      final path = file!.path;
      final String extension = path.split('.').last.toLowerCase();
      if (Constants.supportedExtensions.contains(extension)) {
        validAssets.add(asset);
      } else {
        invalidAssets.add(asset);
      }
    }

    if (invalidAssets.isNotEmpty) {
      if (!context.mounted) return;

      FocusScope.of(context).unfocus();

      Constants.showErrorSnackBarV2(
        context,
        'Some assets have unsupported extensions.',
      );
    }

    // check for _assets size is not greater than 30 MB
    for (int i = 0; i < validAssets.length; i++) {
      final asset = validAssets[i];
      final totalSizeInMegabytes = await calculateTotalSizeInMegabytes(asset);

      if (totalSizeInMegabytes > 30) {
        if (!context.mounted) return;
        Constants.showErrorSnackBarV2(
          context,
          "Total size exceeds 30 MB. You cannot proceed.",
        );
        validAssets.removeAt(i);
        notifyListeners();
      }
    }

    _assets.addAll(validAssets);
    notifyListeners();
  }

  Future<void> pickImagesAndVideos(BuildContext context,
      {bool isVideo = false}) async {
    AssetEntity? media;

    media = await CameraPicker.pickFromCamera(
      context,
      locale: const Locale('en'),
      pickerConfig: CameraPickerConfig(
        enableRecording: isVideo,
        maximumRecordingDuration: const Duration(minutes: 3),
      ),
    );

    if (media == null) return;

    if (isVideo) {
      final totalSizeInMegabytes = await calculateTotalSizeInMegabytes(media);

      if (totalSizeInMegabytes > 30) {
        if (!context.mounted) return;
        Constants.showErrorSnackBarV2(
          context,
          "Total size exceeds 30 MB. You cannot proceed.",
        );
        return;
      }
    }

    _assets.add(media);
    notifyListeners();
  }
}
