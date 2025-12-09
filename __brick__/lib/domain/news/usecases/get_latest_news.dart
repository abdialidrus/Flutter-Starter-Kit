{{#include_example_feature}}
{{#use_api}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../repositories/news_repository.dart';

/// Use case to get latest news with pagination support
class GetLatestNews {
  final NewsRepository _repository;

  GetLatestNews(this._repository);

  /// Execute use case
  /// [page] is the token to load the next page  
  Future<Result<PaginatedNewsResult, Failure>> call({String? page}) async {
    return await _repository.getLatestNews(page: page);
  }
}
{{/use_api}}
{{/include_example_feature}}
