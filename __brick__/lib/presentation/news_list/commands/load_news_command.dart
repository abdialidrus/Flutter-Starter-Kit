{{#include_example_feature}}
{{#use_api}}
import 'package:{{project_name.snakeCase()}}/core/utils/command.dart';
import 'package:{{project_name.snakeCase()}}/core/utils/result.dart';
import 'package:{{project_name.snakeCase()}}/domain/repositories/news_repository.dart';
import 'package:{{project_name.snakeCase()}}/domain/usecases/get_latest_news.dart';

/// Command untuk load latest news dengan pagination support
class LoadNewsCommand extends CommandWithResult<PaginatedNewsResult> {
  final GetLatestNews _getLatestNews;
  final String? page;

  LoadNewsCommand(this._getLatestNews, {this.page});

  @override
  Future<void> execute() async {
    if (running) return;

    setRunning();

    final result = await _getLatestNews(page: page);

    result.when(
      success: (data) {
        setResult(data);
      },
      error: (error) {
        setError(error.message);
      },
    );
  }
}
{{/use_api}}
{{/include_example_feature}}
