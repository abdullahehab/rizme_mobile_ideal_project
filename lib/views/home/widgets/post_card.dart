import 'package:flutter/material.dart';

import '../../../models/post/post.dart';
import 'media_slider_screen.dart';
import 'post_components/post_components.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(PostDetail.routeName, arguments: post);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withAlpha(100),
              width: 0.3,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostHeader(
              user: post.authorUsername,
              circleIcon: post.subRedditIcon,
              circleTitle: post.subReddit,
              createdAt: post.timeStamp,
            ),
            PostBody(
              post: post,
              onMediaSliderOpened: (int index) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MediaSliderScreen(
                      usesNetwork: true,
                      networkAssets: post.images,
                      initialIndex: index,
                    ),
                  ),
                );
              },
            ),
            PostFooter(post: post),
          ],
        ),
      ),
    );
  }
}
