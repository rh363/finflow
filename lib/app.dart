import 'package:finflow_app/core/theme/finflow_theme.dart';
import 'package:flutter/material.dart';

class FinFlowApp extends StatelessWidget {
  const FinFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinFlow',
      theme: FFTheme.glacier(),
      home: Scaffold(body: Center(child: Text('FinFlow - coming soon'))),
    );
  }
}
