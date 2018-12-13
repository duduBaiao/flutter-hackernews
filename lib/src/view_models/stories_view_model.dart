import 'package:news/src/use_cases/stories/fetch_top_stories_ids.dart';
import 'package:rxdart/rxdart.dart';

class StoriesViewModel {
  final FetchTopStoriesIds _fetchTopStoriesIds;
  final _topIds = PublishSubject<List<int>>();

  StoriesViewModel(this._fetchTopStoriesIds);

  Observable<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _fetchTopStoriesIds.execute();
    _topIds.sink.add(ids);
  }

  dispose() {
    _topIds.close();
  }
}
