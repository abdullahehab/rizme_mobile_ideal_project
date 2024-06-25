import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_ideal_project/config/helpers/constants.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImagePreviewWidget extends ConsumerWidget {
  final AssetEntity entity;
  final VoidCallback onDelete;
  const ImagePreviewWidget({
    super.key,
    required this.entity,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: kDefaultMediaPreviewHeight,
          height: kDefaultMediaPreviewHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image(
              image: AssetEntityImageProvider(entity),
              fit: BoxFit.cover,
            ),
          ),
        ),
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
                color: AppColors.holdSeatColor,
              ),
              child: const Icon(
                Icons.delete,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        if (entity.type == AssetType.video) ...[
          const Icon(
            Icons.smart_display,
            color: Colors.red,
            size: 40,
          )
        ]
      ],
    );
  }
}
