{{#include_example_feature}}
{{#use_local_storage}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

/// Use case to bookmark a news article
class BookmarkArticleUseCase {
  final NewsRepository _repository;

  BookmarkArticleUseCase(this._repository);

  Future<Result<void, Failure>> call(NewsEntity news) async {
    return await _repository.bookmarkNews(news);
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
