import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_text_style.dart';

class InputTextWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;

  const InputTextWidget(
      {Key? key,
      required this.label,
      required this.icon,
      this.initialValue,
      this.validator,
      this.controller,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              validator: validator,
              onChanged: onChanged,
              style: TextStyles.input,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: label,
                labelStyle: TextStyles.input,
                border: InputBorder.none,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(
                        icon,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 0,
                        color: AppColors.stroke,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            )
          ],
        ),
      ),
    );
  }
}
