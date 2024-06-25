import 'package:flutter/material.dart';

extension ThemeUtils on BuildContext {
  bool isSmallScreen() {
    return MediaQuery.of(this).size.height < 700;
  }

  TextTheme get theme => Theme.of(this).textTheme;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}
