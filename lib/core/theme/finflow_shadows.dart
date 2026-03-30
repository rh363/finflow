import 'package:flutter/material.dart';

abstract class FFShadows {
  static const List<BoxShadow> sm = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 3,
      color: Color.fromRGBO(0, 0, 0, 0.06),
    ),
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      color: Color.fromRGBO(0, 0, 0, 0.04),
    ),
  ];
  static const List<BoxShadow> md = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      color: Color.fromRGBO(0, 0, 0, 0.08),
    ),
  ];
  static const List<BoxShadow> lg = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      color: Color.fromRGBO(0, 0, 0, 0.12),
    ),
  ];
  static const List<BoxShadow> accent = [
    BoxShadow(offset: Offset(0, 4), blurRadius: 12, color: Color(0x442563EB)),
  ];
}
