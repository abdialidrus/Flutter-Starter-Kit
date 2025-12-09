{{#include_example_feature}}
{{#use_go_router}}
import 'package:{{project_name.snakeCase()}}/domain/entities/news_entity.dart';
import 'package:{{project_name.snakeCase()}}/presentation/news_list/news_list_screen.dart';
import 'package:{{project_name.snakeCase()}}/presentation/news_detail/news_detail_screen.dart';
{{#use_local_storage}}
import 'package:{{project_name.snakeCase()}}/presentation/bookmarks/bookmarks_screen.dart';
{{/use_local_storage}}
import 'package:go_router/go_router.dart';

/// App Router configuration dengan Go Router
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // News List Route
      GoRoute(
        path: '/',
        name: 'news_list',
        builder: (context, state) => const NewsListScreen(),
      ),

      // News Detail Route
      GoRoute(
        path: '/detail',
        name: 'news_detail',
        builder: (context, state) {
          final news = state.extra as NewsEntity;
          return NewsDetailScreen(news: news);
        },
      ),

{{#use_local_storage}}
      // Bookmarks Route
      GoRoute(
        path: '/bookmarks',
        name: 'bookmarks',
        builder: (context, state) => const BookmarksScreen(),
      ),
{{/use_local_storage}}
    ],
  );
}
{{/use_go_router}}
{{/include_example_feature}}
