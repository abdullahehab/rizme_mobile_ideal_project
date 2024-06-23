import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_ideal_project/config/helpers/assets.dart';
import 'package:mobile_ideal_project/config/routers/router.dart';
import 'package:mobile_ideal_project/generated/localization.dart';

class CustomBackButton extends StatelessWidget {
  final double? width;
  final double? height;
  const CustomBackButton({
    super.key,
    this.height,
    this.width = 12,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: router.maybePop,
      icon: Transform.rotate(
        angle: context.isArabic ? math.pi : 0,
        child: SvgPicture.asset(
          AppAssets.backSVG,
          width: width,
        ),
      ),
    );
  }
}
