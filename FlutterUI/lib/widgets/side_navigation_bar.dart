import 'package:flutter/material.dart';

class SideNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onIndexChanged;

  const SideNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.black,
      child: Column(
        children: [
          const SizedBox(height: 56),
          _buildNavItem(0, Icons.restaurant, 'IngredientBuddy'),
          _buildNavItem(1, Icons.visibility_outlined, 'RepoCrawl'),
          _buildNavItem(2, Icons.settings, 'Page Three'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onIndexChanged(index),
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF121212) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
