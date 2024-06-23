import 'package:flutter/material.dart';
import 'package:mobile_ideal_project/components/default_text_field.dart';
import 'package:mobile_ideal_project/config/helpers/theme.dart';
import 'package:mobile_ideal_project/generated/locale_keys.g.dart';
import 'package:mobile_ideal_project/generated/localization.dart';

enum UserGender { male, female, other }

class GanderSelector extends StatefulWidget {
  final UserGender? initialValue;
  final bool enabled;
  final ValueChanged<UserGender> onChanged;

  const GanderSelector({
    required this.onChanged,
    super.key,
    this.initialValue,
    this.enabled = true,
  });

  @override
  State<GanderSelector> createState() => _GanderSelectorState();
}

class _GanderSelectorState extends State<GanderSelector> {
  UserGender selected = UserGender.male;

  @override
  void initState() {
    if (widget.initialValue != null) {
      selected = widget.initialValue!;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GanderSelector oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      selected = widget.initialValue!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.gander.tr(),
          style: textTheme.titleMedium!.copyWith(
            color: AppColors.primaryGreTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: UserGender.values.map(
            (gander) {
              return GanderButton(
                onTap: () {
                  if (!widget.enabled) return;
                  selected = gander;
                  widget.onChanged(gander);
                  setState(() {});
                },
                title: gander.name.tr(),
                selected: gander == selected,
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

class GanderButton extends StatelessWidget {
  const GanderButton({
    required this.title,
    required this.onTap,
    required this.selected,
    super.key,
  });

  final String title;
  final Function()? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: InkWell(
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6.5),
          decoration: BoxDecoration(
            borderRadius: kDefaultTextFieldBorderRadius,
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium!.copyWith(
                    color: AppColors.primaryTextColor,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
