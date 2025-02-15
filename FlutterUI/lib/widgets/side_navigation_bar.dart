import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class NavItem {
  final IconData icon;
  final String label;
  final String route;

  const NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

class SideNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onIndexChanged;

  static const List<NavItem> _navItems = [
    NavItem(
      icon: Icons.restaurant,
      label: 'IngredientBuddy',
      route: '/ingredient-buddy',
    ),
    NavItem(
      icon: Icons.visibility_outlined,
      label: 'RepoCrawl',
      route: '/repo-crawl',
    ),
    NavItem(
      icon: Icons.settings,
      label: 'Settings',
      route: '/settings',
    ),
  ];

  const SideNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: AppSpacing.navWidth,
        color: AppColors.navBackground,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: AppBorders.defaultWidth,
                color: AppColors.borderColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.topBarHeight),
                ..._navItems.asMap().entries.map(
                      (entry) => _buildNavItem(
                        context,
                        entry.key,
                        entry.value.icon,
                        entry.value.label,
                      ),
                    ),
              ],
            ),
          ],
        ),
      );

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
  ) =>
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 4, 0, 4),
        child: InkWell(
          onTap: () {
            onIndexChanged(index);
          },
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? AppColors.primaryDark
                  : Colors.transparent,
              border: selectedIndex == index
                  ? Border(
                      top: BorderSide(
                        color: AppColors.borderColor,
                        width: AppBorders.defaultWidth,
                      ),
                      bottom: BorderSide(
                        color: AppColors.borderColor,
                        width: AppBorders.defaultWidth,
                      ),
                      left: BorderSide(
                        color: AppColors.borderColor,
                        width: AppBorders.defaultWidth,
                      ),
                    )
                  : null,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Icon(icon, color: AppColors.textLight),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.textLight,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
