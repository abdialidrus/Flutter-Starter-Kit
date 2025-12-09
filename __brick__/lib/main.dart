import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/app.dart';
import 'package:{{project_name.snakeCase()}}/core/di/injection_container.dart';
{{#use_local_storage}}
import 'package:{{project_name.snakeCase()}}/core/storage/hive_service.dart';
{{/use_local_storage}}

/// Main entry point
void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

{{#use_local_storage}}
  // Initialize Hive
  await HiveService.init();

{{/use_local_storage}}
  // Setup Dependency Injection
  await setupDependencies();

  // Run app
  runApp(const MyApp());
}
