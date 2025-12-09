{{#include_example_feature}}
{{#use_local_storage}}
import 'package:{{project_name.snakeCase()}}/core/utils/command.dart';
import 'package:{{project_name.snakeCase()}}/core/utils/result.dart';
import 'package:{{project_name.snakeCase()}}/domain/repositories/news_repository.dart';

/// Command untuk remove bookmark
class RemoveBookmarkCommand extends Command {
  final NewsRepository _repository;
  final String _articleId;

  RemoveBookmarkCommand(this._repository, this._articleId);

  @override
  Future<void> execute() async {
    if (running) return;

    setRunning();

    final result = await _repository.removeBookmark(_articleId);

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
