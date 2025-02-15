import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class RepoCrawlPage extends StatelessWidget {
  const RepoCrawlPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: AppColors.primaryDark,
      padding: AppSpacing.pagePadding,
      child: Center(
        child: Text(
          'Repository Crawler',
          style: theme.textTheme.displayMedium,
        ),
      ),
    );
  }
}
