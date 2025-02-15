import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primaryDark = Color(0xFF121212);
  static const Color primaryLight = Color(0xFFFAFAFA);

  // Accent colors
  static const Color accentBlue = Color(0xFF2196F3);
  static const Color accentGreen = Color(0xFF4CAF50);

  // Background colors
  static const Color backgroundDark = Color(0xFF000000);
  static const Color backgroundLight = Color(0xFFFFFFFF);

  // Text colors
  static const Color textDark = Color(0xFF212121);
  static const Color textLight = Color(0xFFFFFFFF);

  // Status colors
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFFA000);
  static const Color info = Color(0xFF1E88E5);

  // Navigation colors
  static const Color navBackground = Color(0xFF000000);
  static const Color navSelectedItem = primaryDark;

  // Component colors
  static const Color borderColor = Color(0xFFFFFFFF);
  static const Color uploadIcon = Color(0xFFFFFFFF);
}

class AppSpacing {
  // Base spacing
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // Navigation specific
  static const double navItemPaddingSides =
      10.0; // New constant for nav item side padding
  static const double topBarHeight = 56.0;
  static const double navItemHeight = 56.0;
  static const double navWidth = 200.0;

  // Component dimensions
  static const Size imageUploadSize = Size(360.0, 640.0);

  // Common paddings
  static const EdgeInsets pagePadding = EdgeInsets.all(md);

  static const EdgeInsets navItemPadding = EdgeInsets.symmetric(
    horizontal: navItemPaddingSides,
    vertical: sm,
  );

  static const double maxContentWidth = 1200.0;
}

class AppBorders {
  static const double defaultRadius = 12.0;
  static const double defaultWidth = 1.0;

  static BorderRadius get defaultBorderRadius =>
      BorderRadius.circular(defaultRadius);

  static Border get defaultBorder => Border.all(
        color: AppColors.borderColor,
        width: defaultWidth,
      );

  static BoxDecoration get navItemSelected => BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: defaultBorderRadius,
        border: defaultBorder,
      );

  static BoxDecoration get navItemDefault => BoxDecoration(
        color: Colors.transparent,
        borderRadius: defaultBorderRadius,
      );

  static BoxDecoration get uploadContainer => BoxDecoration(
        border: defaultBorder,
        borderRadius: defaultBorderRadius,
      );
}

class AppTextStyles {
  static const String fontFamily = 'Roboto';

  static TextStyle get displayLarge => const TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyLarge => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
      );

  // Navigation text
  static TextStyle get navLabel => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  // Upload section text
  static TextStyle get uploadTitle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get uploadSubtitle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get errorText => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.error,
      );
}

class AppIcons {
  static const double defaultSize = 24.0;
  static const double largeSize = 64.0;

  static const IconThemeData navIcon = IconThemeData(
    color: AppColors.textLight,
    size: defaultSize,
  );

  static const IconThemeData uploadIcon = IconThemeData(
    color: AppColors.uploadIcon,
    size: largeSize,
  );
}

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.primaryDark,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.primaryDark,
        textTheme: TextTheme(
          bodyLarge: const TextStyle(
            fontSize: 16,
            color: AppColors.textLight,
          ),
          bodyMedium: const TextStyle(
            fontSize: 14,
            color: AppColors.textLight,
          ),
        ),
        cardTheme: CardTheme(
          color: AppColors.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: AppBorders.defaultBorderRadius,
            side: BorderSide(
              color: AppColors.borderColor,
              width: AppBorders.defaultWidth,
            ),
          ),
        ),
      );

  static ThemeData get lightTheme => darkTheme.copyWith(
        colorScheme: const ColorScheme.light(
          primary: AppColors.accentBlue,
          secondary: AppColors.accentGreen,
          surface: AppColors.primaryLight,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.backgroundLight,
        textTheme: TextTheme(
          displayLarge:
              AppTextStyles.displayLarge.copyWith(color: AppColors.textDark),
          displayMedium:
              AppTextStyles.displayMedium.copyWith(color: AppColors.textDark),
          bodyLarge:
              AppTextStyles.bodyLarge.copyWith(color: AppColors.textDark),
          bodyMedium:
              AppTextStyles.bodyMedium.copyWith(color: AppColors.textDark),
        ),
      );
}
