import 'package:flutter/material.dart';

import '../../config/helpers/media_type_checker.dart';
import '../post_media/post_media.dart';

class Post {
  final int id;
  final String content;
  final String subReddit;
  final String authorUsername;
  final int upvotes;
  final int comments;
  final DateTime timeStamp;
  final String subRedditIcon;
  final Color subRedditColor;
  final List<PostMedia> images;

  Post({
    required this.id,
    required this.content,
    required this.subReddit,
    required this.authorUsername,
    required this.upvotes,
    required this.comments,
    required this.timeStamp,
    required this.subRedditIcon,
    required this.subRedditColor,
    required this.images,
  });

  static List<Post> posts = [
    Post(
      id: 1,
      content: "Flutter 3.0 Goes live",
      images: [
        const PostMedia(
          mediaType: MediaType.image,
          mediaUrl:
              "https://images.unsplash.com/photo-1628277613967-6abca504d0ac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
        )
      ],
      subReddit: "FlutterDev",
      authorUsername: "event_loop",
      upvotes: 69,
      comments: 45,
      timeStamp: DateTime(2022, DateTime.now().month, DateTime.now().day, DateTime.now().hour - 1),
      subRedditIcon: "assets/flutter.png",
      subRedditColor: Colors.lightBlueAccent,
    ),
    Post(
      id: 2,
      content: "NASA makes contact with aliens",
      images: [
        const PostMedia(
          mediaType: MediaType.image,
          mediaUrl:
              "https://images.unsplash.com/photo-1607335614551-3062bf90f30e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
        )
      ],
      subReddit: "News",
      authorUsername: "curiosity_rover",
      upvotes: 600,
      comments: 450,
      timeStamp: DateTime(2022, DateTime.now().month, DateTime.now().day, DateTime.now().hour - 10),
      subRedditIcon: "assets/news.png",
      subRedditColor: Colors.redAccent,
    ),
    Post(
      id: 1,
      content: "Android studio no longer hogging RAM",
      images: [
        const PostMedia(
          mediaType: MediaType.image,
          mediaUrl:
              "https://images.unsplash.com/photo-1604536264507-020ce894daf1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
        )
      ],
      subReddit: "androiddev",
      authorUsername: "livedata",
      upvotes: 99,
      comments: 500,
      timeStamp: DateTime(2022, DateTime.now().month, DateTime.now().day, DateTime.now().hour - 2),
      subRedditIcon: "assets/android.png",
      subRedditColor: Colors.green,
    ),
  ];
}
