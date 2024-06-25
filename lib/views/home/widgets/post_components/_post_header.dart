import 'package:flutter/material.dart';

import '../../../../generated/localization.dart';

class PostHeader extends StatelessWidget {
  final String user;
  final String circleIcon;
  final String circleTitle;
  final DateTime createdAt;
  const PostHeader({
    super.key,
    required this.user,
    required this.circleIcon,
    required this.circleTitle,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4, top: 8),
      child: Row(
        children: [
          Image.asset(
            circleIcon,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "r/$circleTitle",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          "u/$user",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 2),
                        const Text(
                          "•",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          "${DateFormat.H().format(createdAt)}h",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  iconSize: 20,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
