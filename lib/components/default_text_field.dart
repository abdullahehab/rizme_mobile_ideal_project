import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_ideal_project/config/helpers/context_extensions.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';

const kDefaultTextFieldBorderRadius = BorderRadius.all(Radius.circular(15));

class DefaultTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hint;
  final String outlineText;
  final bool enabled;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  const DefaultTextField({
    required this.textEditingController,
    required this.hint,
    super.key,
    this.outlineText = '',
    this.enabled = true,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.outlineText.isNotEmpty)
          Text(
            widget.outlineText,
            style: context.theme.bodySmall!.copyWith(
              color: AppColors.primaryGreTextColor,
            ),
          ),
        TextFormField(
          enabled: widget.enabled,
          controller: widget.textEditingController,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          autocorrect: false,
          enableSuggestions: false,
          textCapitalization: widget.textCapitalization,
          style: context.theme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: widget.enabled
                ? AppColors.primaryTextColor
                : Colors.grey.shade500,
          ),
          inputFormatters: [
            if (widget.inputFormatters != null) ...widget.inputFormatters!,
          ],
          decoration: _buildDecoration(),
        ),
      ],
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      counter: const SizedBox.shrink(),
      hintText: widget.hint,
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
      ),
      filled: true,
      errorMaxLines: 3,
      errorBorder: const OutlineInputBorder(
        borderRadius: kDefaultTextFieldBorderRadius,
        borderSide: BorderSide(color: Colors.red),
      ),
      border: const OutlineInputBorder(
        borderRadius: kDefaultTextFieldBorderRadius,
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: kDefaultTextFieldBorderRadius,
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: kDefaultTextFieldBorderRadius,
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
    );
  }
}
