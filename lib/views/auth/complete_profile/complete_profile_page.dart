import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mobile_ideal_project/components/default_button.dart';
import 'package:mobile_ideal_project/components/default_text_field.dart';
import 'package:mobile_ideal_project/components/dob_text_field.dart';
import 'package:mobile_ideal_project/components/gander_selector.dart';
import 'package:mobile_ideal_project/components/keyboard_dismissal.dart';
import 'package:mobile_ideal_project/components/phone_text_field.dart';
import 'package:mobile_ideal_project/config/helpers/constants.dart';
import 'package:mobile_ideal_project/config/helpers/context_extensions.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';
import 'package:mobile_ideal_project/generated/localization.dart';

@RoutePage()
class CompleteProfilePage extends ConsumerStatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  ConsumerState<CompleteProfilePage> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends ConsumerState<CompleteProfilePage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late TextEditingController _phoneController;

  final _formKey = GlobalKey<FormState>();
  DateTime? _dob;
  UserGender gander = UserGender.male;

  @override
  void initState() {
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> completeProfile() async {
    if (!_formKey.currentState!.validate()) return;

    String phone = _phoneController.text.trim();
    phone = "0$phone";
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissal(
      child: Scaffold(
        body: SafeArea(
          child: PopScope(
            onPopInvoked: (didPop) => false,
            child: SingleChildScrollView(
              padding: Constants.appPadding.copyWith(top: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocaleKeys.complete_profile.tr(),
                      style: context.theme.titleLarge!.copyWith(
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      LocaleKeys.getTheBest.tr(),
                      style: context.theme.titleMedium!.copyWith(
                        color: AppColors.primaryGreTextColor,
                      ),
                    ),
                    const SizedBox(height: 40),
                    DefaultTextField(
                      hint: LocaleKeys.email.tr(),
                      outlineText: LocaleKeys.email.tr(),
                      textEditingController: _emailController,
                      inputFormatters: [
                        TextInputFormatter.withFunction(
                          (oldValue, newValue) {
                            return TextEditingValue(
                              text: newValue.text.replaceAll(' ', ''),
                              selection: newValue.selection,
                            );
                          },
                        ),
                      ],
                      keyboardType: TextInputType.emailAddress,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    const SizedBox(height: 22),
                    PhoneTextField(
                      controller: _phoneController,
                    ),
                    const SizedBox(height: 24),
                    DOBTextField(
                      initialValue: _dob,
                      validator: FormBuilderValidators.required(),
                      onChanged: (DateTime selected) {
                        _dob = selected;
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 26),
                    GanderSelector(
                      onChanged: (UserGender value) {
                        gander = value;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    DefaultButton(
                      onPressed: completeProfile,
                      title: LocaleKeys.complete_profile.tr(),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
