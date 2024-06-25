import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../config/helpers/theme.dart';
import 'video_viewer_screen.dart';

class VideoPreviewWidget extends ConsumerWidget {
  final String? videoPath;
  final String? videoUrl;
  final VoidCallback? onDelete;
  final bool canDelete;
  final double? height;
  final double? width;
  final int? moreVideosCount;
  final BoxFit? fit;
  final bool openViewer;

  const VideoPreviewWidget({
    super.key,
    this.onDelete,
    this.videoPath,
    this.videoUrl,
    this.canDelete = true,
    this.height,
    this.width,
    this.moreVideosCount,
    this.openViewer = false,
    this.fit,
  })  : assert(
          videoUrl != null || videoPath != null,
          "videoUrl or videoPath must be provided",
        ),
        assert(
          (canDelete && onDelete != null) || !canDelete && onDelete == null,
          "If user can delete, onDelete can't be null",
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool hasMoreVideos = moreVideosCount != null && moreVideosCount! >= 1;
    return GestureDetector(
      onTap: !openViewer
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VideoViewerScreen(
                    localFilePath: videoPath,
                    videoUrl: videoUrl,
                  ),
                ),
              );
            },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FutureBuilder<Widget>(
                future: generateVideoThumbnail(videoPath ?? videoUrl!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        snapshot.data!,
                        const Icon(
                          Icons.smart_display,
                          color: Colors.red,
                          size: 40,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade300,
                      ),
                      child: const Icon(
                        Icons.smart_display,
                        color: Colors.red,
                        size: 40,
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          if (canDelete)
            Positioned.directional(
              textDirection: Directionality.of(context),
              top: 3,
              end: 3,
              child: InkWell(
                onTap: onDelete,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.loginGrey,
                  ),
                  child: const Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (hasMoreVideos) ...[
            Align(
              alignment: const AlignmentDirectional(0.85, .85),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                child: Text(
                  '+${moreVideosCount!}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Future<Widget> generateVideoThumbnail(String video) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: video,
      imageFormat: ImageFormat.PNG,
      quality: 100,
    );

    return Image.memory(uint8list!, fit: fit, height: height, width: width);
  }
}
