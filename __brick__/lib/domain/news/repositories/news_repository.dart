{{#include_example_feature}}
import '../../../core/utils/failures.dart';
import '../../../core/utils/result.dart';
import '../entities/news_entity.dart';

/// Response for pagination
class PaginatedNewsResult {
  final List<NewsEntity> news;
  final String? nextPage;
  final int? totalResults;

  PaginatedNewsResult({
    required this.news,
    this.nextPage,
    this.totalResults,
  });
}

/// Repository interface for News
/// Defines the contract between domain and data layer
abstract class NewsRepository {
  {{#use_api}}
  /// Get latest news from remote API with pagination support
  /// [page] is the token to load the next page
  Future<Result<PaginatedNewsResult, Failure>> getLatestNews({String? page});
  {{/use_api}}

  {{#use_local_storage}}
  /// Bookmark news (save to local storage)
  Future<Result<void, Failure>> bookmarkNews(NewsEntity news);

  /// Remove bookmark (delete from local storage)
  Future<Result<void, Failure>> removeBookmark(String articleId);

  /// Get all bookmarked news from local storage
  Future<Result<List<NewsEntity>, Failure>> getBookmarkedNews();

  /// Check if news is bookmarked
  Future<Result<bool, Failure>> isNewsBookmarked(String articleId);
  {{/use_local_storage}}
}
{{/include_example_feature}}
