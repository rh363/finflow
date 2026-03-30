import 'package:flutter/material.dart';

class FFColors extends ThemeExtension<FFColors> {
  // themes colors
  static const glacier = FFColors(
    bgPrimary: Color(0xFFF7F8FA),
    bgCard: Color(0xFFFFFFFF),
    bgCardAlt: Color(0xFFF0F2F5),
    bgSurface: Color(0xFFE8ECF1),
    textPrimary: Color(0xFF1A1D23),
    textSecondary: Color(0xFF6B7280),
    textMuted: Color(0xFF9CA3AF),
    textOnAccent: Color(0xFFFFFFFF),
    accentDefault: Color(0xFF2563EB),
    accentPressed: Color(0xFF1D4ED8),
    accentBg: Color(0xFFDBEAFE),
    semanticPositive: Color(0xFF059669),
    semanticPositiveBg: Color(0xFFD1FAE5),
    semanticNegative: Color(0xFFDC2626),
    semanticNegativeBg: Color(0xFFFEE2E2),
    semanticWarning: Color(0xFFD97706),
    semanticWarningBg: Color(0xFFFEF3C7),
    borderDefault: Color(0xFFE5E7EB),
  );

  // background
  final Color bgPrimary;
  final Color bgCard;
  final Color bgCardAlt;
  final Color bgSurface;

  // text
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textOnAccent;

  // accent
  final Color accentDefault;
  final Color accentPressed;
  final Color accentBg;

  // semantic
  final Color semanticPositive;
  final Color semanticPositiveBg;
  final Color semanticNegative;
  final Color semanticNegativeBg;
  final Color semanticWarning;
  final Color semanticWarningBg;

  // border
  final Color borderDefault;

  const FFColors({
    // background
    required this.bgPrimary,
    required this.bgCard,
    required this.bgCardAlt,
    required this.bgSurface,
    // text
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textOnAccent,
    // accent
    required this.accentDefault,
    required this.accentPressed,
    required this.accentBg,
    // semantic
    required this.semanticPositive,
    required this.semanticPositiveBg,
    required this.semanticNegative,
    required this.semanticNegativeBg,
    required this.semanticWarning,
    required this.semanticWarningBg,
    // border
    required this.borderDefault,
  });

  @override
  ThemeExtension<FFColors> copyWith({
    // background
    Color? bgPrimary,
    Color? bgCard,
    Color? bgCardAlt,
    Color? bgSurface,
    // text
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textOnAccent,
    // accent
    Color? accentDefault,
    Color? accentPressed,
    Color? accentBg,
    // semantic
    Color? semanticPositive,
    Color? semanticPositiveBg,
    Color? semanticNegative,
    Color? semanticNegativeBg,
    Color? semanticWarning,
    Color? semanticWarningBg,
    // border
    Color? borderDefault,
  }) {
    return FFColors(
      // background
      bgPrimary: bgPrimary ?? this.bgPrimary,
      bgCard: bgCard ?? this.bgCard,
      bgCardAlt: bgCardAlt ?? this.bgCardAlt,
      bgSurface: bgSurface ?? this.bgSurface,
      // text
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      textOnAccent: textOnAccent ?? this.textOnAccent,
      // accent
      accentDefault: accentDefault ?? this.accentDefault,
      accentPressed: accentPressed ?? this.accentPressed,
      accentBg: accentBg ?? this.accentBg,
      // semantic
      semanticPositive: semanticPositive ?? this.semanticPositive,
      semanticPositiveBg: semanticPositiveBg ?? this.semanticPositiveBg,
      semanticNegative: semanticNegative ?? this.semanticNegative,
      semanticNegativeBg: semanticNegativeBg ?? this.semanticNegativeBg,
      semanticWarning: semanticWarning ?? this.semanticWarning,
      semanticWarningBg: semanticWarningBg ?? this.semanticWarningBg,
      // border
      borderDefault: borderDefault ?? this.borderDefault,
    );
  }

  @override
  ThemeExtension<FFColors> lerp(
    covariant ThemeExtension<FFColors>? other,
    double t,
  ) {
    if (other is! FFColors) return this;
    return FFColors(
      // background
      bgPrimary: Color.lerp(bgPrimary, other.bgPrimary, t)!,
      bgCard: Color.lerp(bgCard, other.bgCard, t)!,
      bgCardAlt: Color.lerp(bgCardAlt, other.bgCardAlt, t)!,
      bgSurface: Color.lerp(bgSurface, other.bgSurface, t)!,
      // text
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textOnAccent: Color.lerp(textOnAccent, other.textOnAccent, t)!,
      // accent
      accentDefault: Color.lerp(accentDefault, other.accentDefault, t)!,
      accentPressed: Color.lerp(accentPressed, other.accentPressed, t)!,
      accentBg: Color.lerp(accentBg, other.accentBg, t)!,
      // semantic
      semanticPositive: Color.lerp(
        semanticPositive,
        other.semanticPositive,
        t,
      )!,
      semanticPositiveBg: Color.lerp(
        semanticPositiveBg,
        other.semanticPositiveBg,
        t,
      )!,
      semanticNegative: Color.lerp(
        semanticNegative,
        other.semanticNegative,
        t,
      )!,
      semanticNegativeBg: Color.lerp(
        semanticNegativeBg,
        other.semanticNegativeBg,
        t,
      )!,
      semanticWarning: Color.lerp(semanticWarning, other.semanticWarning, t)!,
      semanticWarningBg: Color.lerp(
        semanticWarningBg,
        other.semanticWarningBg,
        t,
      )!,
      // border
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
    );
  }
}

extension FFColorsExtension on BuildContext {
  FFColors get ffColors => Theme.of(this).extension<FFColors>()!;
}
