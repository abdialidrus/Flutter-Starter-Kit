{{#include_example_feature}}
{{#use_local_storage}}
import 'package:{{project_name.snakeCase()}}/core/utils/command.dart';
import 'package:{{project_name.snakeCase()}}/core/utils/result.dart';
import 'package:{{project_name.snakeCase()}}/domain/entities/news_entity.dart';
import 'package:{{project_name.snakeCase()}}/domain/usecases/get_bookmarked_articles_usecase.dart';

/// Command untuk load bookmarked news
class LoadBookmarkedNewsCommand extends CommandWithResult<List<NewsEntity>> {
  final GetBookmarkedArticlesUseCase _getBookmarkedArticles;

  LoadBookmarkedNewsCommand(this._getBookmarkedArticles);

  @override
  Future<void> execute() async {
    if (running) return;

    setRunning();

    final result = await _getBookmarkedArticles();

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
{{/use_local_storage}}
{{/include_example_feature}}
