{{#include_example_feature}}
{{#use_api}}
import 'package:flutter/foundation.dart';
import 'package:{{project_name.snakeCase()}}/domain/entities/news_entity.dart';
import 'package:{{project_name.snakeCase()}}/domain/usecases/get_latest_news.dart';
import 'package:{{project_name.snakeCase()}}/presentation/news_list/commands/load_news_command.dart';

/// ViewModel untuk News List Screen dengan pagination support
class NewsListViewModel extends ChangeNotifier {
  final GetLatestNews _getLatestNews;

  NewsListViewModel({required GetLatestNews getLatestNews})
    : _getLatestNews = getLatestNews;

  // Commands
  LoadNewsCommand? _loadNewsCommand;
  LoadNewsCommand? _loadMoreCommand;

  // State
  List<NewsEntity> _newsList = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;
  String? _nextPageToken;
  bool _hasMoreData = true;
  int? _totalResults;

  // Getters
  List<NewsEntity> get newsList => _newsList;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get isEmpty => _newsList.isEmpty && !_isLoading && !hasError;
  bool get hasMoreData => _hasMoreData;
  int? get totalResults => _totalResults;

  /// Load news (initial load atau refresh)
  Future<void> loadNews() async {
    _isLoading = true;
    _errorMessage = null;
    _nextPageToken = null;
    _hasMoreData = true;
    notifyListeners();

    _loadNewsCommand?.dispose();
    _loadNewsCommand = LoadNewsCommand(_getLatestNews);
    _loadNewsCommand!.addListener(() => _onCommandChanged(isLoadMore: false));
    await _loadNewsCommand!.execute();
  }

  /// Refresh news
  Future<void> refreshNews() async {
    _errorMessage = null;
    _nextPageToken = null;
    _hasMoreData = true;

    _loadNewsCommand?.dispose();
    _loadNewsCommand = LoadNewsCommand(_getLatestNews);
    _loadNewsCommand!.addListener(() => _onCommandChanged(isLoadMore: false));
    await _loadNewsCommand!.execute();
  }

  /// Load more news (pagination)
  Future<void> loadMoreNews() async {
    // Cek apakah sedang loading atau tidak ada data lagi
    if (_isLoadingMore || !_hasMoreData || _nextPageToken == null) {
      return;
    }

    _isLoadingMore = true;
    _errorMessage = null;
    notifyListeners();

    _loadMoreCommand?.dispose();
    _loadMoreCommand = LoadNewsCommand(_getLatestNews, page: _nextPageToken);
    _loadMoreCommand!.addListener(() => _onCommandChanged(isLoadMore: true));
    await _loadMoreCommand!.execute();
  }

  /// Listener untuk command changes
  void _onCommandChanged({required bool isLoadMore}) {
    final command = isLoadMore ? _loadMoreCommand : _loadNewsCommand;
    if (command == null) return;

    if (isLoadMore) {
      _isLoadingMore = command.running;
    } else {
      _isLoading = command.running;
    }

    if (command.completed && command.result != null) {
      final result = command.result!;

      if (isLoadMore) {
        // Append news untuk pagination
        _newsList.addAll(result.news);
      } else {
        // Replace news untuk initial load/refresh
        _newsList = result.news;
      }

      _nextPageToken = result.nextPage;
      _totalResults = result.totalResults;
      _hasMoreData = result.nextPage != null && result.nextPage!.isNotEmpty;
      _errorMessage = null;
    }

    if (command.hasError) {
      _errorMessage = command.error.toString();
      if (isLoadMore) {
        _isLoadingMore = false;
      } else {
        _isLoading = false;
      }
    }

    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _loadNewsCommand?.removeListener(
      () => _onCommandChanged(isLoadMore: false),
    );
    _loadNewsCommand?.dispose();
    _loadMoreCommand?.removeListener(() => _onCommandChanged(isLoadMore: true));
    _loadMoreCommand?.dispose();
    super.dispose();
  }
}
{{/use_api}}
{{/include_example_feature}}
