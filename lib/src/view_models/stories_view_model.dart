import 'package:news/src/domain/repositories/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesViewModel {
  final NewsRepository _repository;
  final _topIds = PublishSubject<List<int>>();

  StoriesViewModel(this._repository);

  Observable<List<int>> get topIds => _topIds.stream;

  //TODO: Should use a "Use Case" instead of calling the repository directly
  fetchTopIds() async {
    final ids = await _repository.fetchTopStoriesIds();
    _topIds.sink.add(ids);
  }

  dispose() {
    _topIds.close();
  }
}
