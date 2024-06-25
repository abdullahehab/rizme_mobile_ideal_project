import 'package:flutter/material.dart';
import '../../generated/localization.dart';

Locale detectContentLocale(String content) {
  if (Bidi.startsWithRtl(content)) return const Locale("ar");
  return const Locale("en");
}

Alignment decideAlignment(BuildContext context, String content) {
  Locale? contentLocale = detectContentLocale(content);
  bool isEnContext = context.locale.languageCode == "en";

  if (contentLocale.languageCode == context.locale.languageCode) {
    if (isEnContext) return Alignment.centerLeft;
    return Alignment.centerRight;
  }

  if (isEnContext) return Alignment.centerRight;
  return Alignment.centerLeft;
}

TextAlign decideTextAlignment(BuildContext context, String content) {
  Locale? contentLocale = detectContentLocale(content);
  bool isEnContext = context.locale.languageCode == "en";
  if (contentLocale.languageCode == context.locale.languageCode) {
    if (isEnContext) return TextAlign.left;
    return TextAlign.right;
  }

  if (isEnContext) return TextAlign.right;
  return TextAlign.left;
}
