import 'package:get_it/get_it.dart';
{{#use_api}}import 'package:dio/dio.dart';{{/use_api}}

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  {{#use_api}}
  // Dio
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: '{{api_base_url}}',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    
    // Add interceptors if needed
    // dio.interceptors.add(LogInterceptor());
    
    return dio;
  });
  {{/use_api}}

  // Register your dependencies here
  // Example:
  // getIt.registerLazySingleton<YourRepository>(() => YourRepositoryImpl());
  // getIt.registerFactory<YourViewModel>(() => YourViewModel(getIt()));
}
