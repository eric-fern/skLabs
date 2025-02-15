import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class AIOutputDisplay extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AIOutputDisplay({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.textLight
                .withAlpha(128), // 0.5 opacity = 128 in alpha
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: AppBorders.defaultBorderRadius,
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: AppBorders.defaultWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppBorders.defaultBorderRadius,
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: AppBorders.defaultWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppBorders.defaultBorderRadius,
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: AppBorders.defaultWidth,
            ),
          ),
        ),
        style: const TextStyle(
          color: AppColors.textLight,
          fontSize: 16,
        ),
      );
}
