import 'package:news/src/use_cases/stories/fetch_item_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_top_stories_ids_use_case.dart';
import 'package:rxdart/rxdart.dart';

class StoriesViewModel {
  final FetchTopStoriesIdsUseCase _fetchTopStoriesIdsUseCase;
  final FetchItemUseCase _fetchItemUseCase;

  final _topIds = PublishSubject<List<int>>();

  StoriesViewModel(this._fetchTopStoriesIdsUseCase, this._fetchItemUseCase);

  Observable<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _fetchTopStoriesIdsUseCase.execute();
    _topIds.sink.add(ids);
  }

  fetchItem(int id) async {
    final item = await _fetchItemUseCase.execute(id);
  }

  dispose() {
    _topIds.close();
  }
}
