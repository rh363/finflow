import 'package:finflow_app/app.dart';
import 'package:finflow_app/core/database/app_database.dart';
import 'package:flutter/material.dart';

import 'core/database/connection.dart';

void main() {
  final db = AppDatabase(openConnection());
  runApp(const FinFlowApp());
  // runApp(const FinFlowAppGallery());
}
