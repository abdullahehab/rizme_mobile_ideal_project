import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeField extends StatelessWidget {
  final ValueChanged<String>? onCompleted;
  final TextEditingController otpController;
  final FormFieldValidator<String?> validator;

  const PinCodeField({
    required this.onCompleted,
    required this.validator,
    required this.otpController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FormField<String>(
        validator: validator,
        builder: (field) => Column(
          children: [
            PinCodeTextField(
              controller: otpController,
              autoDisposeControllers: false,
              autoFocus: true,
              appContext: context,
              pastedTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              animationType: AnimationType.fade,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                activeColor: AppColors.pinCodeColor,
                disabledColor: Colors.green,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 43,
                fieldWidth: 43,
                inactiveColor:
                    field.hasError ? Colors.red : AppColors.pinCodeColor,
                selectedColor: AppColors.pinCodeColor,
                selectedFillColor: AppColors.pinCodeColor,
                inactiveFillColor: AppColors.pinCodeColor,
                activeFillColor: AppColors.pinCodeColor,
              ),
              cursorColor: AppColors.primaryTextColor,
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              onCompleted: (value) {
                onCompleted!.call(value);
              },
              onChanged: (value) {
                // ignore: invalid_use_of_protected_member
                field.setValue(value);
                field.validate();
                // onChanged!.call(value);
              },
              beforeTextPaste: (text) {
                return true;
              },
            ),
            Visibility(
              visible: field.hasError,
              child: Text(
                field.errorText ?? "ERROR",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                  height: 0.75,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
