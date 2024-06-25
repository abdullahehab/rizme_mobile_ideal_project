import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const int kDefaultContentLines = 3;
const int kDefaultContentMaxVisibleLength = 240;
const double kDefaultMediaPreviewHeight = 110;

class Constants {
  Constants._();
  static const appPadding = EdgeInsets.symmetric(horizontal: 35);

  static Future<void> openLink(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  // Fonts
  static const String rubikFontFamily = "Rubik";
  static const String ralewayFontFamily = "Raleway";
  static const String cairoFontFamily = "Cairo";
}
