{{#include_example_feature}}
{{#use_local_storage}}
import 'dart:convert';

import 'package:{{project_name.snakeCase()}}/core/storage/hive_service.dart';
import 'package:{{project_name.snakeCase()}}/data/models/news_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Local Data Source untuk News (menggunakan Hive)
class NewsLocalDataSource {
  static const String _boxName = HiveService.newsBoxName;

  /// Get bookmarked news box
  Future<Box<String>> _getBox() async {
    return await HiveService.openBox<String>(_boxName);
  }

  /// Save news to local storage (bookmark)
  Future<void> saveNews(NewsModel news) async {
    if (news.articleId == null) {
      throw Exception('Article ID cannot be null');
    }

    final box = await _getBox();
    final jsonString = jsonEncode(news.toJson());
    await box.put(news.articleId, jsonString);
  }

  /// Delete news from local storage (remove bookmark)
  Future<void> deleteNews(String articleId) async {
    final box = await _getBox();
    await box.delete(articleId);
  }

  /// Get all bookmarked news
  Future<List<NewsModel>> getAllBookmarkedNews() async {
    final box = await _getBox();
    final List<NewsModel> newsList = [];

    for (var jsonString in box.values) {
      try {
        final json = jsonDecode(jsonString);
        final news = NewsModel.fromJson(json);
        newsList.add(news);
      } catch (e) {
        // Skip invalid data
        continue;
      }
    }

    return newsList;
  }

  /// Check if news is bookmarked
  Future<bool> isBookmarked(String articleId) async {
    final box = await _getBox();
    return box.containsKey(articleId);
  }

  /// Get single bookmarked news by ID
  Future<NewsModel?> getBookmarkedNews(String articleId) async {
    final box = await _getBox();
    final jsonString = box.get(articleId);

    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString);
      return NewsModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  /// Clear all bookmarked news
  Future<void> clearAllBookmarks() async {
    final box = await _getBox();
    await box.clear();
  }

  /// Get total bookmarks count
  Future<int> getBookmarksCount() async {
    final box = await _getBox();
    return box.length;
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
