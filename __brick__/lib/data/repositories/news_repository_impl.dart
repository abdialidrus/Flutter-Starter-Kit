{{#include_example_feature}}
{{#use_api}}
import 'package:dio/dio.dart';
{{/use_api}}
import 'package:{{project_name.snakeCase()}}/core/utils/failures.dart';
import 'package:{{project_name.snakeCase()}}/core/utils/result.dart';
{{#use_local_storage}}
import 'package:{{project_name.snakeCase()}}/data/datasources/news_local_datasource.dart';
{{/use_local_storage}}
{{#use_api}}
import 'package:{{project_name.snakeCase()}}/data/datasources/news_remote_datasource.dart';
{{/use_api}}
import 'package:{{project_name.snakeCase()}}/data/models/news_model.dart';
import 'package:{{project_name.snakeCase()}}/domain/entities/news_entity.dart';
import 'package:{{project_name.snakeCase()}}/domain/repositories/news_repository.dart';

/// Implementation dari News Repository
class NewsRepositoryImpl implements NewsRepository {
{{#use_api}}
  final NewsRemoteDataSource _remoteDataSource;
{{/use_api}}
{{#use_local_storage}}
  final NewsLocalDataSource _localDataSource;
{{/use_local_storage}}

  NewsRepositoryImpl({
{{#use_api}}
    required NewsRemoteDataSource remoteDataSource,
{{/use_api}}
{{#use_local_storage}}
    required NewsLocalDataSource localDataSource,
{{/use_local_storage}}
  }){{#use_api}} : final _remoteDataSource = remoteDataSource{{#use_local_storage}},
       final _localDataSource = localDataSource{{/use_local_storage}}{{/use_api}}{{^use_api}}{{#use_local_storage}} : final _localDataSource = localDataSource{{/use_local_storage}}{{/use_api}};

{{#use_api}}
  @override
  Future<Result<PaginatedNewsResult, Failure>> getLatestNews({String? page}) async {
    try {
      final response = await _remoteDataSource.getLatestNews(page: page);

      if (response.results == null || response.results!.isEmpty) {
        return const Error(NotFoundFailure('No news found'));
      }

      final entities = response.results!
          .map((model) => model.toEntity())
          .toList();

      final result = PaginatedNewsResult(
        news: entities,
        nextPage: response.nextPage,
        totalResults: response.totalResults,
      );

      return Success(result);
    } on DioException catch (e) {
      return Error(_handleDioException(e));
    } catch (e) {
      return Error(UnexpectedFailure(e.toString()));
    }
  }
{{/use_api}}

{{#use_local_storage}}
  @override
  Future<Result<void, Failure>> bookmarkNews(NewsEntity news) async {
    try {
      if (news.articleId == null) {
        return const Error(ClientFailure('Article ID is required'));
      }

      final model = NewsModel.fromEntity(news);
      await _localDataSource.saveNews(model);

      return const Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> removeBookmark(String articleId) async {
    try {
      await _localDataSource.deleteNews(articleId);
      return const Success(null);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<NewsEntity>, Failure>> getBookmarkedNews() async {
    try {
      final models = await _localDataSource.getAllBookmarkedNews();
      final entities = models.map((model) => model.toEntity()).toList();

      return Success(entities);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool, Failure>> isNewsBookmarked(String articleId) async {
    try {
      final isBookmarked = await _localDataSource.isBookmarked(articleId);
      return Success(isBookmarked);
    } catch (e) {
      return Error(CacheFailure(e.toString()));
    }
  }
{{/use_local_storage}}

{{#use_api}}
  /// Helper method untuk handle Dio exceptions
  Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');

      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        if (statusCode != null) {
          if (statusCode >= 500) {
            return ServerFailure('Server error: $statusCode');
          } else if (statusCode >= 400) {
            return ClientFailure('Client error: $statusCode');
          }
        }
        return const ServerFailure();

      case DioExceptionType.cancel:
        return const ClientFailure('Request cancelled');

      default:
        return UnexpectedFailure(exception.message ?? 'Unknown error');
    }
  }
{{/use_api}}
}
{{/include_example_feature}}
