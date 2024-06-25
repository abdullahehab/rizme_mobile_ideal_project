import 'dart:io';

import 'package:wechat_assets_picker/wechat_assets_picker.dart';

Future<List<File>> assetEntityToFile(List<AssetEntity> entities) async {
  final List<File> paths = [];
  for (var entity in entities) {
    final file = await entity.file;
    paths.add(File(file!.path));
  }

  return paths;
}

Future<int> calculateTotalSizeInBytes(AssetEntity asset) async {
  int totalSizeInBytes = 0;
  final file = await asset.file;

  totalSizeInBytes += await file!.length();

  return totalSizeInBytes;
}

Future<double> calculateTotalSizeInMegabytes(AssetEntity asset) async {
  int totalSizeInBytes = await calculateTotalSizeInBytes(asset);
  double totalSizeInMegabytes = totalSizeInBytes / (1024 * 1024);
  return totalSizeInMegabytes;
}
