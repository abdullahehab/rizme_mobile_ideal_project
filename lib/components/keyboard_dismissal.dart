import 'package:flutter/material.dart';

class KeyboardDismissal extends StatelessWidget {
  final Widget child;
  const KeyboardDismissal({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
