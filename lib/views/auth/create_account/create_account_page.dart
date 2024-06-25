import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../components/auth_app_bar.dart';
import '../../../components/default_button.dart';
import '../../../components/default_text_field.dart';
import '../../../components/keyboard_dismissal.dart';
import '../../../components/phone_text_field.dart';
import '../../../config/helpers/constants.dart';
import '../../../config/helpers/context_extensions.dart';
import '../../../config/helpers/textfields_helpers.dart';
import '../../../config/helpers/theme.dart';
import '../../../generated/localization.dart';

@RoutePage()
class CreateAccountPage extends ConsumerStatefulWidget {
  const CreateAccountPage({super.key});

  @override
  ConsumerState<CreateAccountPage> createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccountPage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    if (!_formKey.currentState!.validate()) return;
  }

  void changeLoading(bool loading) {
    if (loading == isLoading) return;
    isLoading = loading;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissal(
      child: Scaffold(
        appBar: const AuthAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: Constants.appPadding.copyWith(top: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const WelcomeText(),
                  const SizedBox(height: 40),
                  DefaultTextField(
                    hint: LocaleKeys.firstName.tr(),
                    outlineText: LocaleKeys.firstName.tr(),
                    textEditingController: _firstNameController,
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [onlyCharactersFormatter],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 26),
                  DefaultTextField(
                    hint: LocaleKeys.lastName.tr(),
                    outlineText: LocaleKeys.lastName.tr(),
                    textEditingController: _lastNameController,
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [onlyCharactersFormatter],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(height: 26),
                  PhoneTextField(controller: _phoneController),
                  const SizedBox(height: 30),
                  DefaultButton(
                    isLoading: isLoading,
                    onPressed: registerUser,
                    title: LocaleKeys.next.tr(),
                  ),
                  const SizedBox(height: 25),
                  const HaveAnAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.createAccount.tr(),
          style: context.theme.titleLarge!.copyWith(
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          LocaleKeys.getTheBest.tr(),
          style: textTheme.bodyLarge!.copyWith(
            color: AppColors.primaryGreTextColor,
          ),
        ),
      ],
    );
  }
}

class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          recognizer: TapGestureRecognizer()..onTap = () {},
          text: LocaleKeys.alreadyHaveAnAccount.tr(),
          style: context.theme.bodyMedium,
          children: [
            const TextSpan(text: "\t"),
            TextSpan(
              text: LocaleKeys.goBack.tr(),
              style: context.theme.bodyMedium!.copyWith(
                color: AppColors.primaryTextColor,
                fontWeight: FontWeight.w800,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.router.maybePop(),
            ),
          ],
        ),
      ),
    );
  }
}
