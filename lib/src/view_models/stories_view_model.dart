import 'dart:async';

import 'package:news/src/domain/models/item_model.dart';
import 'package:news/src/use_cases/stories/clear_stories_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_item_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_top_stories_ids_use_case.dart';
import 'package:rxdart/rxdart.dart';

class StoriesViewModel {
  StoriesViewModel(
    this._fetchTopStoriesIdsUseCase,
    this._fetchItemUseCase,
    this._clearStoriesUseCase,
  );

  final FetchTopStoriesIdsUseCase _fetchTopStoriesIdsUseCase;
  final FetchItemUseCase _fetchItemUseCase;
  final ClearStoriesUseCase _clearStoriesUseCase;

  final _topIds = BehaviorSubject<List<int>>();
  final _itemsCache = Map<int, Future<ItemModel>>();

  Observable<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _fetchTopStoriesIdsUseCase.execute();
    _topIds.sink.add(ids);
  }

  Future<ItemModel> fetchItem(int itemId) {
    return _itemsCache[itemId] ??= _fetchItemUseCase.execute(itemId);
  }

  clearStories() async {
    await _clearStoriesUseCase.execute();
    _itemsCache.clear();
  }

  dispose() {
    _topIds.close();
  }
}
