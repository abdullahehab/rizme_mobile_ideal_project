import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/default_button.dart';
import '../../../components/keyboard_dismissal.dart';
import '../../../components/phone_text_field.dart';
import '../../../config/helpers/context_extensions.dart';
import '../../../config/helpers/snackbars.dart';
import '../../../config/helpers/theme.dart';
import '../../../config/routers/router.dart';
import '../../../generated/localization.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  final ValueChanged<bool>? onResult;
  const LoginPage({
    super.key,
    this.onResult,
  });

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    _phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void changeLoading(bool loading) {
    if (loading == isLoading) return;
    isLoading = loading;
    if (mounted) setState(() {});
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;
    changeLoading(true);
    try {
      String phone = _phoneController.text.trim();
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      await context.router.push(
        OTPRoute(
          phone: phone,
          onResult: widget.onResult,
        ),
      );
    } on Exception catch (e) {
      if (mounted) {
        unawaited(handleErrorSnackBar(context, e));
      }
    } finally {
      changeLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissal(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 200),
                  const SizedBox(height: 16),
                  PhoneTextField(controller: _phoneController),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: DefaultButton(
                      isLoading: isLoading,
                      onPressed: submit,
                      title: LocaleKeys.login.tr(),
                    ),
                  ),
                  const SizedBox(height: 31),
                  const DoseNotHaveAccount(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DoseNotHaveAccount extends StatelessWidget {
  const DoseNotHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: LocaleKeys.doestHaveAccountOnDiscover.tr(),
          style: context.theme.bodySmall,
          children: [
            const TextSpan(text: "\t"),
            TextSpan(
              text: LocaleKeys.createAccount.tr(),
              style: context.theme.bodySmall!.copyWith(
                color: AppColors.primaryTextColor,
                fontWeight: FontWeight.w800,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.router.push(const CreateAccountRoute());
                },
            ),
          ],
        ),
      ),
    );
  }
}
