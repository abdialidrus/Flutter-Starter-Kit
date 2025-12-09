{{#include_example_feature}}
{{#use_api}}
import 'package:dio/dio.dart';
import 'package:{{project_name.snakeCase()}}/core/constants/api_constants.dart';
import 'package:{{project_name.snakeCase()}}/core/network/dio_client.dart';
import 'package:{{project_name.snakeCase()}}/data/models/news_model.dart';

/// Remote Data Source untuk News
class NewsRemoteDataSource {
  final DioClient _dioClient;

  NewsRemoteDataSource(this._dioClient);

  /// Get latest news from API
  /// [page] adalah token untuk load page berikutnya (dari response sebelumnya)
  Future<NewsResponseModel> getLatestNews({String? page}) async {
    try {
      final queryParameters = {ApiConstants.apiKeyParam: ApiConstants.apiKey};

      // Tambahkan page parameter jika ada (untuk pagination)
      if (page != null && page.isNotEmpty) {
        queryParameters['page'] = page;
      }

      final response = await _dioClient.get(
        ApiConstants.latestNewsEndpoint,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return NewsResponseModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed to load news: ${response.statusCode}',
        );
      }
    } on DioException {
      rethrow;
    }
  }
}
{{/use_api}}
{{/include_example_feature}}
