{{#include_example_feature}}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:{{project_name.snakeCase()}}/core/di/injection_container.dart';
import 'package:{{project_name.snakeCase()}}/domain/entities/news_entity.dart';
{{#use_local_storage}}
import 'package:{{project_name.snakeCase()}}/domain/usecases/bookmark_article_usecase.dart';
import 'package:{{project_name.snakeCase()}}/domain/repositories/news_repository.dart';
{{/use_local_storage}}
import 'package:{{project_name.snakeCase()}}/presentation/news_detail/news_detail_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

/// News Detail Screen
class NewsDetailScreen extends StatelessWidget {
  final NewsEntity news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsDetailViewModel(
{{#use_local_storage}}
        bookmarkArticle: getIt<BookmarkArticleUseCase>(),
        repository: getIt<NewsRepository>(),
{{/use_local_storage}}
      )..init(news),
      child: const _NewsDetailView(),
    );
  }
}

class _NewsDetailView extends StatelessWidget {
  const _NewsDetailView();

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsDetailViewModel>(
      builder: (context, viewModel, child) {
        final news = viewModel.news;

        return Scaffold(
          appBar: AppBar(
            title: const Text('News Detail'),
            actions: [
const {{#use_local_storage}}
              if (viewModel.isLoading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              else
                IconButton(
                  icon: Icon(
                    viewModel.isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  ),
                  onPressed: () => viewModel.toggleBookmark(),
                  tooltip: viewModel.isBookmarked
                      ? 'Remove bookmark'
                      : 'Bookmark',
                ),
{{/use_local_storage}}
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                if (news.imageUrl != null)
                  Image.network(
                    news.imageUrl!,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 64),
                        ),
                      );
                    },
                  ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      if (news.title != null)
                        Text(
                          news.title!,
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),

                      const SizedBox(height: 16),

                      // Metadata
                      Row(
                        children: [
                          // Source
                          if (news.sourceName != null) ...[
                            Icon(Icons.article_outlined,
                                size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              news.sourceName!,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(width: 16),
                          ],

                          // Date
                          if (news.pubDate != null) ...[
                            Icon(Icons.access_time,
                                size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              _formatDate(news.pubDate!),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Categories
                      if (news.category != null && news.category!.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: news.category!
                              .map((category) => Chip(
                                    label: Text(category),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                  ))
                              .toList(),
                        ),

                      const SizedBox(height: 24),

                      // Description
                      if (news.description != null)
                        Text(
                          news.description!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),

                      const SizedBox(height: 16),

                      // Content
                      if (news.content != null)
                        Text(
                          news.content!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                      const SizedBox(height: 24),

                      // Read more button
                      if (news.link != null)
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () => _launchUrl(news.link!),
                            icon: const Icon(Icons.open_in_new),
                            label: const Text('Read Full Article'),
                          ),
                        ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMMM dd, yyyy • HH:mm').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
{{/include_example_feature}}
