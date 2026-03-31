import 'package:finflow_app/core/theme/finflow_theme.dart';
import 'package:finflow_app/core/widgets/widget_gallery_screen.dart';
import 'package:flutter/material.dart';

class FinFlowApp extends StatelessWidget {
  const FinFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinFlow',
      theme: FFTheme.glacier(),
      home: const WidgetGalleryScreen(),
    );
  }
}
