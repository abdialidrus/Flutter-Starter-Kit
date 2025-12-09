{{#include_example_feature}}
{{#use_local_storage}}
import 'package:{{project_name.snakeCase()}}/core/utils/command.dart';
import 'package:{{project_name.snakeCase()}}/core/utils/result.dart';
import 'package:{{project_name.snakeCase()}}/domain/entities/news_entity.dart';
import 'package:{{project_name.snakeCase()}}/domain/usecases/bookmark_article_usecase.dart';

/// Command untuk bookmark news
class BookmarkNewsCommand extends Command {
  final BookmarkArticleUseCase _bookmarkArticle;
  final NewsEntity _news;

  BookmarkNewsCommand(this._bookmarkArticle, this._news);

  @override
  Future<void> execute() async {
    if (running) return;

    setRunning();

    final result = await _bookmarkArticle(_news);

    result.when(
      success: (_) {
        setCompleted();
      },
      error: (error) {
        setError(error.message);
      },
    );
  }
}
{{/use_local_storage}}
{{/include_example_feature}}
