import 'package:flutter/material.dart';

const int kDefaultContentLines = 3;
const int contentMaxVisibleLength = 240;
const double kDefaultMediaPreviewHeight = 110;

class Constants {
  Constants._();
  static const appPadding = EdgeInsets.symmetric(horizontal: 35);

  // Fonts
  static const String rubikFontFamily = "Rubik";
  static const String ralewayFontFamily = "Raleway";
  static const String cairoFontFamily = "Cairo";
  static const supportedExtensions = {
    'jpeg',
    'png',
    'jpg',
    'svg',
    'mp4',
    '3gp',
    'mkv',
    'avi',
    'mov',
    'wmv'
  };
  static const supportedImagesExtensions = {
    'jpeg',
    'png',
    'jpg',
    'svg',
  };

  static void showErrorSnackBarV2(BuildContext context, String msg) {
    assert(context.mounted, "Context is not mounted");
    final sm = ScaffoldMessenger.of(context);
    sm
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade400,
          content: Text(msg),
        ),
      );
  }
}
