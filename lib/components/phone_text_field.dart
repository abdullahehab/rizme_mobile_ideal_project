import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mobile_ideal_project/components/default_text_field.dart';
import 'package:mobile_ideal_project/config/helpers/assets.dart';
import 'package:mobile_ideal_project/config/helpers/context_extensions.dart';
import 'package:mobile_ideal_project/config/helpers/textfields_helpers.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';
import 'package:mobile_ideal_project/generated/localization.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  const PhoneTextField({
    required this.controller,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.phone.tr(),
          style: context.theme.bodySmall!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.primaryGreTextColor,
          ),
        ),
        Directionality(
          textDirection: material.TextDirection.ltr,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: kDefaultTextFieldBorderRadius,
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 11,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '+20',
                        style: context.theme.titleMedium,
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(AppAssets.dropArrow),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: DefaultTextField(
                  hint: "100 123 4567",
                  enabled: enabled,
                  textEditingController: controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.match(
                      egyptianPhoneNumberRegex,
                      errorText: LocaleKeys.invalidMobile.tr(),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
