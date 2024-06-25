import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ideal_project/config/helpers/constants.dart';
import 'package:mobile_ideal_project/config/helpers/context_extensions.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';

enum PickType { camera, gallery }

class UploadMediaCard extends StatelessWidget {
  final VoidCallback? onTap;
  final PickType pickType;
  const UploadMediaCard({
    super.key,
    this.onTap,
    required this.pickType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: kDefaultMediaPreviewHeight,
        height: kDefaultMediaPreviewHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pickType == PickType.camera) ...[
              const Icon(
                CupertinoIcons.camera_fill,
                size: 32,
                color: AppColors.holdSeatColor,
              ),
              const SizedBox(height: 10),
              Text(
                "Photo/Video",
                style: context.theme.bodySmall!.copyWith(
                  color: AppColors.holdSeatColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (pickType == PickType.gallery) ...[
              const Icon(
                CupertinoIcons.photo_on_rectangle,
                size: 32,
                color: AppColors.holdSeatColor,
              ),
              const SizedBox(height: 10),
              Text(
                "Upload Media",
                style: context.theme.bodySmall!.copyWith(
                  color: AppColors.holdSeatColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
