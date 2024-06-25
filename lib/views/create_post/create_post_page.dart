import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_ideal_project/config/helpers/context_extensions.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';
import 'package:mobile_ideal_project/providers/create_post_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'widgets/widgets.dart';

@RoutePage()
class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  late final TextEditingController _contentController;
  @override
  void initState() {
    _contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(createPostProvider);
    final provider = ref.read(createPostProvider.notifier);
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
          const UserInfoSection(),
          const SizedBox(height: 10),
          TextFormField(
            controller: _contentController,
            maxLines: 10,
            autocorrect: false,
            decoration: InputDecoration(
              fillColor: Colors.grey.shade100,
              filled: true,
              hintText: "What's on your mind?",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              onPressed: () async {},
              style: TextButton.styleFrom(
                foregroundColor: AppColors.darkOrange,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: const Icon(Icons.add),
              label: const Text("Add Hashtag"),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.start,
            runSpacing: 8,
            spacing: 8,
            children: [
              UploadMediaCard(
                pickType: PickType.camera,
                onTap: () async {
                  await provider.pickImagesAndVideos(context);
                },
              ),
              UploadMediaCard(
                pickType: PickType.gallery,
                onTap: () async {
                  await provider.pickPicturesFromGallery(context);
                },
              ),
              if (provider.assets.isNotEmpty)
                ...provider.assets.map((asset) {
                  final type = asset.type;

                  if (type == AssetType.image || type == AssetType.video) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MediaSliderScreen(
                              usesNetwork: false,
                              localAssets: provider.assets,
                              initialIndex: provider.assets.indexOf(asset),
                            ),
                          ),
                        );
                      },
                      child: ImagePreviewWidget(
                        entity: asset,
                        onDelete: () {
                          provider.remove(asset);
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                }),
            ],
          ),
        ],
      ),
    );
  }
}
