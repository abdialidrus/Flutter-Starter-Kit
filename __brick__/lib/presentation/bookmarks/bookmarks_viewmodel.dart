{{#include_example_feature}}
{{#use_local_storage}}
import 'package:flutter/foundation.dart';
import 'package:{{project_name.snakeCase()}}/domain/entities/news_entity.dart';
import 'package:{{project_name.snakeCase()}}/domain/usecases/get_bookmarked_articles_usecase.dart';
import 'package:{{project_name.snakeCase()}}/domain/repositories/news_repository.dart';
import 'package:{{project_name.snakeCase()}}/presentation/bookmarks/commands/delete_bookmark_command.dart';
import 'package:{{project_name.snakeCase()}}/presentation/bookmarks/commands/load_bookmarked_news_command.dart';

/// ViewModel untuk Bookmarks Screen
class BookmarksViewModel extends ChangeNotifier {
  final GetBookmarkedArticlesUseCase _getBookmarkedArticles;
  final NewsRepository _repository;

  BookmarksViewModel({
    required GetBookmarkedArticlesUseCase getBookmarkedArticles,
    required NewsRepository repository,
  })  : _getBookmarkedArticles = getBookmarkedArticles,
        _repository = repository {
    _loadBookmarkedNewsCommand = LoadBookmarkedNewsCommand(_getBookmarkedArticles);
    _loadBookmarkedNewsCommand.addListener(_onCommandChanged);
  }

  // Commands
  late final LoadBookmarkedNewsCommand _loadBookmarkedNewsCommand;

  // State
  List<NewsEntity> _bookmarkedNewsList = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  LoadBookmarkedNewsCommand get loadBookmarkedNewsCommand =>
      _loadBookmarkedNewsCommand;
  List<NewsEntity> get bookmarkedNewsList => _bookmarkedNewsList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get isEmpty => _bookmarkedNewsList.isEmpty && !_isLoading && !hasError;

  /// Listener untuk command changes
  void _onCommandChanged() {
    _isLoading = _loadBookmarkedNewsCommand.running;

    if (_loadBookmarkedNewsCommand.completed &&
        _loadBookmarkedNewsCommand.result != null) {
      _bookmarkedNewsList = _loadBookmarkedNewsCommand.result!;
      _errorMessage = null;
    }

    if (_loadBookmarkedNewsCommand.hasError) {
      _errorMessage = _loadBookmarkedNewsCommand.error.toString();
    }

    notifyListeners();
  }

  /// Load bookmarked news
  Future<void> loadBookmarkedNews() async {
    await _loadBookmarkedNewsCommand.execute();
  }

  /// Refresh bookmarked news
  Future<void> refreshBookmarkedNews() async {
    _loadBookmarkedNewsCommand.clear();
    await loadBookmarkedNews();
  }

  /// Delete bookmark
  Future<bool> deleteBookmark(String articleId) async {
    final command = DeleteBookmarkCommand(_repository, articleId);

    await command.execute();

    final success = command.completed;

    if (success) {
      // Remove from local list
      _bookmarkedNewsList.removeWhere((news) => news.articleId == articleId);
      notifyListeners();
    } else if (command.hasError) {
      _errorMessage = command.error.toString();
      notifyListeners();
    }

    command.dispose();
    return success;
  }

  /// Clear error
  void clearError() {
    _errorMessage = null;
    _loadBookmarkedNewsCommand.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _loadBookmarkedNewsCommand.removeListener(_onCommandChanged);
    _loadBookmarkedNewsCommand.dispose();
    super.dispose();
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
