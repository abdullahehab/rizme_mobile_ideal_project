import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_ideal_project/components/default_text_field.dart';
import 'package:mobile_ideal_project/config/helpers/assets.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';
import 'package:mobile_ideal_project/generated/locale_keys.g.dart';
import 'package:mobile_ideal_project/generated/localization.dart';

class DOBTextField extends StatefulWidget {
  final ValueChanged<DateTime> onChanged;
  final DateTime? initialValue;
  final bool enabled;
  final FormFieldValidator<DateTime>? validator;
  const DOBTextField({
    required this.onChanged,
    super.key,
    this.initialValue,
    this.enabled = true,
    this.validator,
  });

  @override
  State<DOBTextField> createState() => _DOBTextFieldState();
}

class _DOBTextFieldState extends State<DOBTextField> {
  final fieldState = GlobalKey<FormFieldState<DateTime>>();
  DateTime? _dateOfBirth;

  @override
  void initState() {
    _dateOfBirth = widget.initialValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DOBTextField oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      _dateOfBirth = widget.initialValue;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        fieldState.currentState?.didChange(_dateOfBirth);
        fieldState.currentState?.validate();
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  String? formateDate(DateTime? date) {
    if (date == null) return null;
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> pickDateOfBirth() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(1980),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 15 * 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: AppColors.secondaryColor,
              onPrimary: AppColors.primaryTextColor,
              onSurface: AppColors.primaryTextColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date == null) return;

    _dateOfBirth = date;
    widget.onChanged(date);
    fieldState.currentState?.didChange(date);
    fieldState.currentState?.validate();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDateSelected = _dateOfBirth != null;
    return FormField<DateTime>(
      key: fieldState,
      validator: widget.validator,
      enabled: widget.enabled,
      builder: (FormFieldState<DateTime> field) {
        return InkWell(
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          onTap: () {
            if (!widget.enabled) return;
            pickDateOfBirth();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.dOB.tr(),
                style: textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryGreTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: kDefaultTextFieldBorderRadius,
                  border: Border.all(
                    color: field.hasError ? Colors.red : AppColors.borderColor,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                alignment: AlignmentDirectional.centerStart,
                child: Row(
                  children: [
                    Text(
                      formateDate(_dateOfBirth) ?? LocaleKeys.dOB.tr(),
                      style: _dobTextStyle(isDateSelected),
                    ),
                    const Spacer(),
                    SvgPicture.asset(AppAssets.calender),
                  ],
                ),
              ),
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 8,
                  ),
                  child: Text(
                    field.errorText ?? '',
                    style: textTheme.bodySmall!.copyWith(
                      color: Colors.red[900],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  TextStyle _dobTextStyle(bool isDateSelected) {
    final textTheme = Theme.of(context).textTheme;
    if (!isDateSelected) {
      return textTheme.bodyLarge!.copyWith(
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 13,
      );
    }
    if (!widget.enabled) {
      return textTheme.titleMedium!.copyWith(
        color: AppColors.disabledPrimaryTextColor,
      );
    }

    return textTheme.titleMedium!.copyWith(
      color: AppColors.primaryTextColor,
    );
  }
}
