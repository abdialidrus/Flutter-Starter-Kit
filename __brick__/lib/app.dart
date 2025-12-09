import 'package:flutter/material.dart';
{{#use_go_router}}
{{#include_example_feature}}
import 'package:{{project_name.snakeCase()}}/app/router.dart';
{{/include_example_feature}}
{{/use_go_router}}
{{^use_go_router}}
{{#include_example_feature}}
import 'package:{{project_name.snakeCase()}}/presentation/news_list/news_list_screen.dart';
{{/include_example_feature}}
{{/use_go_router}}

/// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
{{#use_go_router}}
{{#include_example_feature}}
    return MaterialApp.router(
      title: '{{project_name.titleCase()}}',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
{{/include_example_feature}}
{{^include_example_feature}}
    return MaterialApp.router(
      title: '{{project_name.titleCase()}}',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
{{/include_example_feature}}
{{/use_go_router}}
{{^use_go_router}}
    return MaterialApp(
      title: '{{project_name.titleCase()}}',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
const {{#include_example_feature}}
      home: const NewsListScreen(),
{{/include_example_feature}}
{{^include_example_feature}}
      home: Scaffold(
        appBar: AppBar(title: const Text('{{project_name.titleCase()}}')),
        body: const Center(
          child: Text('Welcome to {{project_name.titleCase()}}!'),
        ),
      ),
{{/include_example_feature}}
    );
{{/use_go_router}}
  }
}
