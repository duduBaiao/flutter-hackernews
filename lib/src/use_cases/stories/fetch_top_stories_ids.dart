import 'package:news/src/domain/repositories/news_repository.dart';

class FetchTopStoriesIds {
  final NewsRepository _repository;

  FetchTopStoriesIds(this._repository);

  Future<List<int>> execute() {
    return _repository.fetchTopStoriesIds();
  }
}
