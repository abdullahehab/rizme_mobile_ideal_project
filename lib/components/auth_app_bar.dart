import 'package:flutter/material.dart';
import 'package:mobile_ideal_project/components/back_button.dart';
import 'package:mobile_ideal_project/config/routers/router.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = router.canPop();
    return AppBar(
      leading: canPop
          ? const Padding(
              padding: EdgeInsets.all(20.0),
              child: CustomBackButton(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
