{{#include_example_feature}}
{{#use_api}}
import 'package:flutter/material.dart';
{{#use_go_router}}
import 'package:go_router/go_router.dart';
{{/use_go_router}}
import 'package:provider/provider.dart';
import 'package:{{project_name.snakeCase()}}/core/di/injection_container.dart';
import 'package:{{project_name.snakeCase()}}/domain/usecases/get_latest_news.dart';
import 'package:{{project_name.snakeCase()}}/presentation/news_list/news_list_viewmodel.dart';
import 'package:{{project_name.snakeCase()}}/presentation/news_list/widgets/news_card.dart';

/// News List Screen with infinite scroll
class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsListViewModel(
        getLatestNews: getIt<GetLatestNews>(),
      )..loadNews(),
      child: const _NewsListView(),
    );
  }
}

class _NewsListView extends StatefulWidget {
  const _NewsListView();

  @override
  State<_NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<_NewsListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<NewsListViewModel>().loadMoreNews();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{project_name.titleCase()}}'),
        actions: [
const {{#use_local_storage}}
          IconButton(
            icon: const Icon(Icons.bookmarks_outlined),
            onPressed: () {
{{#use_go_router}}
              context.push('/bookmarks');
{{/use_go_router}}
{{^use_go_router}}
              // Navigate to bookmarks
{{/use_go_router}}
            },
            tooltip: 'Bookmarks',
          ),
{{/use_local_storage}}
        ],
      ),
      body: Consumer<NewsListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.newsList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.hasError && viewModel.newsList.isEmpty) {
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
                    onPressed: () => viewModel.refreshNews(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.article_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No news available'),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => viewModel.refreshNews(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.refreshNews(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: viewModel.newsList.length + (viewModel.hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= viewModel.newsList.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: viewModel.isLoadingMore
                          ? const CircularProgressIndicator()
                          : const SizedBox.shrink(),
                    ),
                  );
                }

                final news = viewModel.newsList[index];
                return NewsCard(
                  news: news,
                  onTap: () {
{{#use_go_router}}
                    context.push('/detail', extra: news);
{{/use_go_router}}
{{^use_go_router}}
                    // Navigate to detail
{{/use_go_router}}
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
{{/use_api}}
{{/include_example_feature}}
