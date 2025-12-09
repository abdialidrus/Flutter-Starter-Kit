{{#include_example_feature}}
{{#use_local_storage}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

/// Use case to get all bookmarked articles
class GetBookmarkedArticlesUseCase {
  final NewsRepository _repository;

  GetBookmarkedArticlesUseCase(this._repository);

  Future<Result<List<NewsEntity>, Failure>> call() async {
    return await _repository.getBookmarkedNews();
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
