import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class ScrollableItemsList extends StatelessWidget {
  final int itemCount;
  final double width;
  final double height;

  const ScrollableItemsList({
    super.key,
    this.itemCount = 10,
    this.width = 360,
    this.height = 320,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        decoration: AppBorders.uploadContainer,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: itemCount,
          separatorBuilder: (_, __) => Divider(
            height: AppBorders.defaultWidth,
            thickness: AppBorders.defaultWidth,
            color: AppColors.borderColor,
          ),
          itemBuilder: (_, __) => const SizedBox(
            height: 64,
            child: Icon(Icons.article_outlined,
                color: AppColors.textLight, size: 32),
          ),
        ),
      );
}
