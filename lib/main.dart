import 'package:finflow_app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('it_IT', null);
  runApp(const ProviderScope(child: FinFlowApp()));
  // runApp(const FinFlowAppGallery());
  // runApp(
  //   const ProviderScope(child: FinFlowTestPage(child: CategoriesScreen())),
  // );
}
