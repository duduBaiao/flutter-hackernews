import 'package:news/src/domain/repositories/news_repository.dart';

class FetchTopStoriesIdsUseCase {
  final NewsRepository _repository;

  FetchTopStoriesIdsUseCase(this._repository);

  Future<List<int>> execute() => _repository.fetchTopStoriesIds();
}
