import 'package:news/src/domain/repositories/news_repository.dart';

class ClearStoriesUseCase {
  ClearStoriesUseCase(this._repository);

  final NewsRepository _repository;

  Future<int> execute() => _repository.clearStories();
}
