{{#include_example_feature}}
import 'package:flutter/foundation.dart';
import 'package:{{project_name.snakeCase()}}/domain/entities/news_entity.dart';
{{#use_local_storage}}
import 'package:{{project_name.snakeCase()}}/domain/usecases/bookmark_article_usecase.dart';
import 'package:{{project_name.snakeCase()}}/domain/repositories/news_repository.dart';
import 'package:{{project_name.snakeCase()}}/presentation/news_detail/commands/bookmark_news_command.dart';
import 'package:{{project_name.snakeCase()}}/presentation/news_detail/commands/remove_bookmark_command.dart';
{{/use_local_storage}}

/// ViewModel untuk News Detail Screen
class NewsDetailViewModel extends ChangeNotifier {
{{#use_local_storage}}
  final BookmarkArticleUseCase _bookmarkArticle;
  final NewsRepository _repository;

  NewsDetailViewModel({
    required BookmarkArticleUseCase bookmarkArticle,
    required NewsRepository repository,
  })  : _bookmarkArticle = bookmarkArticle,
        _repository = repository;
{{/use_local_storage}}
{{^use_local_storage}}
  NewsDetailViewModel();
{{/use_local_storage}}

  // State
  late NewsEntity _news;
{{#use_local_storage}}
  bool _isBookmarked = false;
  bool _isLoading = false;
  String? _errorMessage;
{{/use_local_storage}}

  // Getters
  NewsEntity get news => _news;
{{#use_local_storage}}
  bool get isBookmarked => _isBookmarked;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
{{/use_local_storage}}

  /// Initialize dengan news entity
  Future<void> init(NewsEntity news) async {
    _news = news;
{{#use_local_storage}}
    await _checkBookmarkStatus();
{{/use_local_storage}}
  }

{{#use_local_storage}}
  /// Check apakah news sudah dibookmark
  Future<void> _checkBookmarkStatus() async {
    if (_news.articleId == null) return;

    final result = await _repository.isNewsBookmarked(_news.articleId!);
    result.when(
      success: (isBookmarked) {
        _isBookmarked = isBookmarked;
        notifyListeners();
      },
      error: (_) {
        _isBookmarked = false;
        notifyListeners();
      },
    );
  }

  /// Toggle bookmark
  Future<void> toggleBookmark() async {
    if (_news.articleId == null) {
      _errorMessage = 'Cannot bookmark news without article ID';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (_isBookmarked) {
      // Remove bookmark
      final command = RemoveBookmarkCommand(_repository, _news.articleId!);
      await command.execute();

      if (command.completed) {
        _isBookmarked = false;
        _errorMessage = null;
      } else if (command.hasError) {
        _errorMessage = command.error.toString();
      }

      command.dispose();
    } else {
      // Add bookmark
      final command = BookmarkNewsCommand(_bookmarkArticle, _news);
      await command.execute();

      if (command.completed) {
        _isBookmarked = true;
        _errorMessage = null;
      } else if (command.hasError) {
        _errorMessage = command.error.toString();
      }

      command.dispose();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
{{/use_local_storage}}
}
{{/include_example_feature}}
