import 'dart:io';

import 'package:flutter/material.dart';

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../generated/localization.dart';


class VideoViewerScreen extends StatefulWidget {
  final String? videoUrl;
  final String? localFilePath;
  final bool showAppBar;

  const VideoViewerScreen({
    super.key,
    this.videoUrl,
    this.localFilePath,
    this.showAppBar = true,
  }) : assert(
          videoUrl != null || localFilePath != null,
          "videoUrl or localFilePath must be provided",
        );

  @override
  State<VideoViewerScreen> createState() => _VideoViewerScreenState();
}

class _VideoViewerScreenState extends State<VideoViewerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    if (widget.localFilePath != null) {
      _videoPlayerController =
          VideoPlayerController.file(File(widget.localFilePath!));
    } else {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!));
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> _initVideoPlayer() async {
    if (!_videoPlayerController.value.isInitialized) {
      await _videoPlayerController.initialize();
    }

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      allowedScreenSleep: false,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildPlayerAppBar(),
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: FutureBuilder(
            future: _initVideoPlayer(),
            builder: (context, snapshot) {
              if (_videoPlayerController.value.isInitialized) {
                return AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: Chewie(
                    controller: _chewieController!.copyWith(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                    ),
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget? _buildPlayerAppBar() {
    if (!widget.showAppBar) return null;
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      title: Text(
        LocaleKeys.videoPlayer.tr(),
      ),
    );
  }
}
