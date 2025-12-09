import 'package:get_it/get_it.dart';
{{#use_api}}
import 'package:dio/dio.dart';
{{/use_api}}
{{#use_local_storage}}
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
{{/use_local_storage}}
{{#include_example_feature}}
import '../../domain/news/repositories/news_repository.dart';
import '../../domain/news/usecases/get_news_usecase.dart';
import '../../domain/news/usecases/bookmark_article_usecase.dart';
import '../../domain/news/usecases/get_bookmarked_articles_usecase.dart';
import '../../data/news/datasources/news_remote_datasource.dart';
{{#use_local_storage}}
import '../../data/news/datasources/news_local_datasource.dart';
import '../../data/news/models/news_article_model.dart';
{{/use_local_storage}}
import '../../data/news/repositories/news_repository_impl.dart';
import '../../presentation/news/news_list/news_list_viewmodel.dart';
import '../../presentation/news/news_detail/news_detail_viewmodel.dart';
{{#use_local_storage}}
import '../../presentation/news/bookmarks/bookmarks_viewmodel.dart';
{{/use_local_storage}}
{{/include_example_feature}}

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  {{#use_local_storage}}
  // Initialize Hive
  await Hive.initFlutter();
  {{#include_example_feature}}
  
  // Register Hive adapters
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(NewsArticleModelAdapter());
  }
  
  // Open boxes
  await Hive.openBox<NewsArticleModel>('bookmarks');
  {{/include_example_feature}}
  {{/use_local_storage}}
  
  {{#use_api}}
  // Dio
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: '{{api_base_url}}',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      queryParameters: {
        'apikey': '{{newsdata_api_key}}',
      },
    ));
    
    // Add interceptors if needed
    // dio.interceptors.add(LogInterceptor(
    //   requestBody: true,
    //   responseBody: true,
    // ));
    
    return dio;
  });
  {{/use_api}}
  
  {{#include_example_feature}}
  // Data sources
  {{#use_api}}
  getIt.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(getIt()),
  );
  {{/use_api}}
  {{#use_local_storage}}
  getIt.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(),
  );
  {{/use_local_storage}}
  
  // Repository
  getIt.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      {{#use_api}}remoteDataSource: getIt(),{{/use_api}}
      {{#use_local_storage}}localDataSource: getIt(),{{/use_local_storage}}
    ),
  );
  
  // Use cases
  getIt.registerLazySingleton(() => GetNewsUseCase(getIt()));
  {{#use_local_storage}}
  getIt.registerLazySingleton(() => BookmarkArticleUseCase(getIt()));
  getIt.registerLazySingleton(() => GetBookmarkedArticlesUseCase(getIt()));
  {{/use_local_storage}}
  
  // ViewModels
  getIt.registerFactory(() => NewsListViewModel(getIt()));
  getIt.registerFactory(() => NewsDetailViewModel(
    {{#use_local_storage}}bookmarkArticleUseCase: getIt(),{{/use_local_storage}}
  ));
  {{#use_local_storage}}
  getIt.registerFactory(() => BookmarksViewModel(getIt()));
  {{/use_local_storage}}
  {{/include_example_feature}}
  
  // Register your custom dependencies here
  // Example:
  // getIt.registerLazySingleton<YourRepository>(() => YourRepositoryImpl());
  // getIt.registerFactory<YourViewModel>(() => YourViewModel(getIt()));
}
