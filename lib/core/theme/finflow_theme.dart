import 'package:finflow_app/core/theme/finflow_colors.dart';
import 'package:finflow_app/core/theme/finflow_typography.dart';
import 'package:flutter/material.dart';

abstract class FFTheme {
  static ThemeData glacier() {
    const colors = FFColors.glacier;
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: colors.accentDefault,
        onPrimary: colors.textOnAccent,
        surface: colors.bgCard,
        onSurface: colors.textPrimary,
        error: colors.semanticNegative,
        onError: colors.textOnAccent,
        secondary: colors.accentDefault,
        onSecondary: colors.textOnAccent,
      ),
      scaffoldBackgroundColor: colors.bgPrimary,
      textTheme: TextTheme(
        displayLarge: FFTypography.displayLg,
        displayMedium: FFTypography.displayMd,
        displaySmall: FFTypography.displaySm,
        headlineLarge: FFTypography.headingLg,
        headlineMedium: FFTypography.headingMd,
        headlineSmall: FFTypography.headingSm,
        bodyLarge: FFTypography.bodyLg,
        bodyMedium: FFTypography.bodyMd,
        bodySmall: FFTypography.bodySm,
        labelLarge: FFTypography.caption,
        labelMedium: FFTypography.captionXs,
        labelSmall: FFTypography.overline,
      ),
      extensions: [colors],
    );
  }
}
