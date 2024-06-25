import 'package:flutter/material.dart';
import 'package:mobile_ideal_project/config/helpers/context_extensions.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
