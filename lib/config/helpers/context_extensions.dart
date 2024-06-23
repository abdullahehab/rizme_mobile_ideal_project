import 'package:flutter/material.dart';

extension ThemeUtils on BuildContext {
  bool isSmallScreen() {
    return MediaQuery.of(this).size.height < 700;
  }

  TextTheme get theme => Theme.of(this).textTheme;
}
