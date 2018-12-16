import 'package:news/src/domain/repositories/news_repository.dart';

class FetchTopStoriesIdsUseCase {
  FetchTopStoriesIdsUseCase(this._repository);

  final NewsRepository _repository;

  Future<List<int>> execute() => _repository.fetchTopStoriesIds();
}
