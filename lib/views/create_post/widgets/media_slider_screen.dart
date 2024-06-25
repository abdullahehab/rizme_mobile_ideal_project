import 'package:flutter/material.dart';
import 'package:mobile_ideal_project/config/helpers/media_type_checker.dart';
import 'package:mobile_ideal_project/models/post_media/post_media.dart';
import 'package:mobile_ideal_project/views/create_post/widgets/video_viewer.dart';

import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MediaSliderScreen extends StatefulWidget {
  final List<AssetEntity>? localAssets;
  final List<PostMedia>? networkAssets;
  final int initialIndex;
  final bool usesNetwork;

  MediaSliderScreen({
    super.key,
    required this.usesNetwork,
    this.networkAssets,
    this.localAssets,
    this.initialIndex = 0,
  }) : assert(
          (usesNetwork && networkAssets != null && networkAssets.isNotEmpty) ||
              (!usesNetwork && localAssets != null && localAssets.isNotEmpty),
          usesNetwork
              ? "Network Assets can't be empty"
              : "Local Assets can't be empty",
        );

  @override
  State<MediaSliderScreen> createState() => _MediaSliderScreenState();
}

class _MediaSliderScreenState extends State<MediaSliderScreen> {
  late final PageController _pageController;
  bool get usesNetwork => widget.usesNetwork;
  List<PostMedia>? get networkAssets => widget.networkAssets;
  List<AssetEntity>? get localAssets => widget.localAssets;
  int get mediaLength =>
      usesNetwork ? networkAssets!.length : localAssets!.length;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("imagesText"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: mediaLength,
              itemBuilder: (context, index) {
                if (usesNetwork) {
                  return _buildNetworkMediaWidget(index);
                }
                return _buildLocalMediaWidget(index);
              },
            ),
            Align(
              alignment: const Alignment(0.0, 0.9),
              child: AnimatedBuilder(
                animation: _pageController,
                builder: (context, _) {
                  final page = _pageController.page ?? widget.initialIndex;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(mediaLength, (index) {
                      final isSelected = page.toInt() == index;
                      return Container(
                        margin: const EdgeInsets.all(4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocalMediaWidget(int index) {
    final asset = localAssets![index];
    if (asset.type == AssetType.image) {
      return InteractiveViewer(
        child: Image(
          image: AssetEntityImageProvider(asset),
          fit: BoxFit.contain,
        ),
      );
    }

    return FutureBuilder<String>(
      future: getPath(asset),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while fetching the path
        } else if (snapshot.hasError) {
          return const Text('Error loading video'); // Handle error state
        } else {
          return VideoViewerScreen(
            showAppBar: false,
            localFilePath: snapshot.data!,
          );
        }
      },
    );
  }

  Future<String> getPath(AssetEntity entity) async {
    final file = await entity.file;
    return file!.path;
  }

  Widget _buildNetworkMediaWidget(int index) {
    final asset = networkAssets![index];
    if (asset.mediaType == MediaType.image) {
      return InteractiveViewer(
        child: Image.network(asset.mediaUrl, fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        }),
      );
    }
    return VideoViewerScreen(
      showAppBar: false,
      videoUrl: asset.mediaUrl,
    );
  }
}
