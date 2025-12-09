{{#include_example_feature}}
{{#use_local_storage}}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
{{#use_go_router}}
import 'package:go_router/go_router.dart';
{{/use_go_router}}
import 'package:{{project_name.snakeCase()}}/core/di/injection_container.dart';
import 'package:{{project_name.snakeCase()}}/domain/usecases/get_bookmarked_articles_usecase.dart';
import 'package:{{project_name.snakeCase()}}/domain/repositories/news_repository.dart';
import 'package:{{project_name.snakeCase()}}/presentation/bookmarks/bookmarks_viewmodel.dart';
import 'package:{{project_name.snakeCase()}}/presentation/news_list/widgets/news_card.dart';

/// Bookmarks Screen
class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookmarksViewModel(
        getBookmarkedArticles: getIt<GetBookmarkedArticlesUseCase>(),
        repository: getIt<NewsRepository>(),
      )..loadBookmarkedNews(),
      child: const _BookmarksView(),
    );
  }
}

class _BookmarksView extends StatelessWidget {
  const _BookmarksView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: Consumer<BookmarksViewModel>(
        builder: (context, viewModel, child) {
          // Loading state
          if (viewModel.isLoading && viewModel.bookmarkedNewsList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (viewModel.hasError && viewModel.bookmarkedNewsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    viewModel.errorMessage ?? 'An error occurred',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => viewModel.refreshBookmarkedNews(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Empty state
          if (viewModel.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmarks_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No bookmarks yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bookmark articles to read them later',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                ],
              ),
            );
          }

          // Success state with data
          return RefreshIndicator(
            onRefresh: () => viewModel.refreshBookmarkedNews(),
            child: ListView.builder(
              itemCount: viewModel.bookmarkedNewsList.length,
              itemBuilder: (context, index) {
                final news = viewModel.bookmarkedNewsList[index];
                return Dismissible(
                  key: Key(news.articleId ?? index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Remove Bookmark'),
                          content: const Text(
                            'Are you sure you want to remove this bookmark?',
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Remove',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) async {
                    if (news.articleId != null) {
                      final success = await viewModel.deleteBookmark(news.articleId!);
                      
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success
                                  ? 'Bookmark removed'
                                  : 'Failed to remove bookmark',
                            ),
                            backgroundColor: success ? Colors.green : Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: NewsCard(
                    news: news,
                    onTap: () {
{{#use_go_router}}
                      context.push('/detail', extra: news);
{{/use_go_router}}
{{^use_go_router}}
                      // Navigate to detail
{{/use_go_router}}
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
