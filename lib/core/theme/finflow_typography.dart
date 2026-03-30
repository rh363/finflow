import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FFTypography {
  // display
  static final TextStyle displayLg = GoogleFonts.instrumentSerif(
    fontWeight: FontWeight.w700,
    fontSize: 36,
    height: 1.1,
  );
  static final TextStyle displayMd = GoogleFonts.instrumentSerif(
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 1.15,
  );
  static final TextStyle displaySm = GoogleFonts.instrumentSerif(
    fontWeight: FontWeight.w600,
    fontSize: 22,
    height: 1.2,
  );

  // heading
  static final TextStyle headingLg = GoogleFonts.dmSans(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.25,
  );
  static final TextStyle headingMd = GoogleFonts.dmSans(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.3,
  );
  static final TextStyle headingSm = GoogleFonts.dmSans(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.35,
  );

  // body
  static final TextStyle bodyLg = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
  );
  static final TextStyle bodyMd = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.5,
  );
  static final TextStyle bodySm = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 1.45,
  );

  // caption
  static final TextStyle caption = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.4,
  );
  static final TextStyle captionXs = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 11,
    height: 1.35,
  );
  static final TextStyle overline = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.4,
    letterSpacing: 0.6,
  );
}
