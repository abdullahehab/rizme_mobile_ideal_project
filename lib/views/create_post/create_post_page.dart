import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ideal_project/config/helpers/context_extensions.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';

@RoutePage()
class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Create Post",
            style: context.theme.titleMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: AppColors.darkOrange,
                textStyle: context.theme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text("Post"),
            ),
          ]),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assetName"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Ahmed Elsankary",
                  style: context.theme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
