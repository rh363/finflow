import 'package:finflow_app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: FinFlowApp()));
  // runApp(const FinFlowAppGallery());
  // runApp(
  //   const ProviderScope(child: FinFlowTestPage(child: CategoriesScreen())),
  // );
}
