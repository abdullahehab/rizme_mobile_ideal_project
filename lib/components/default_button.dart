import 'package:flutter/material.dart';
import 'package:mobile_ideal_project/config/helpers/context_extensions.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool isLoading;
  final bool enable;
  final bool borderedButton;
  final Widget? icon;

  const DefaultButton({
    required this.title,
    this.onPressed,
    this.isLoading = false,
    this.enable = true,
    this.borderedButton = false,
    super.key,
  }) : icon = null;

  const DefaultButton.icon({
    required this.title,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
    this.enable = true,
    super.key,
  }) : borderedButton = false;

  const DefaultButton.outlined({
    required this.onPressed,
    required this.title,
    super.key,
    this.isLoading = false,
    this.enable = true,
  })  : borderedButton = true,
        icon = null;

  ButtonStyle _buttonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      animationDuration: const Duration(milliseconds: 100),
      padding: const EdgeInsets.symmetric(vertical: 14),
      backgroundColor:
          borderedButton ? Colors.transparent : AppColors.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      foregroundColor:
          borderedButton ? AppColors.darkerSecondaryColor : Colors.white,
      textStyle: context.theme.titleMedium!.copyWith(
        fontWeight: FontWeight.bold,
      ),
      side: borderedButton
          ? const BorderSide(
              width: 2.0,
              color: AppColors.borderColor,
            )
          : BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: enable && !isLoading ? onPressed : null,
        style: _buttonStyle(context),
        icon: icon!,
        label: _buildButtonChild(context),
      );
    }
    return ElevatedButton(
      onPressed: enable && !isLoading ? onPressed : null,
      style: _buttonStyle(context),
      child: _buildButtonChild(context),
    );
  }

  Widget _buildButtonChild(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: AppColors.secondaryColor,
          ),
        ),
      );
    }
    return Text(title);
  }
}
