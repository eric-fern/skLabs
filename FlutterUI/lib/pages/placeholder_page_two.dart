import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class PlaceholderPageTwo extends StatelessWidget {
  const PlaceholderPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: AppColors.primaryDark,
      padding: AppSpacing.pagePadding,
      child: Center(
        child: Text(
          'Page Three',
          style: theme.textTheme.displayMedium,
        ),
      ),
    );
  }
}
