import 'dart:async';

import 'package:news/src/domain/models/item_model.dart';
import 'package:news/src/use_cases/stories/fetch_item_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_top_stories_ids_use_case.dart';
import 'package:rxdart/rxdart.dart';

class StoriesViewModel {
  final FetchTopStoriesIdsUseCase _fetchTopStoriesIdsUseCase;
  final FetchItemUseCase _fetchItemUseCase;

  StoriesViewModel(this._fetchTopStoriesIdsUseCase, this._fetchItemUseCase);

  final _topIds = BehaviorSubject<List<int>>();
  final _itemsCache = Map<int, Future<ItemModel>>();

  Observable<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _fetchTopStoriesIdsUseCase.execute();
    _topIds.sink.add(ids);
  }

  Future<ItemModel> fetchItem(int id) {
    return _itemsCache[id] = (_itemsCache[id] ?? _fetchItemUseCase.execute(id));
  }

  dispose() {
    _topIds.close();
  }
}
