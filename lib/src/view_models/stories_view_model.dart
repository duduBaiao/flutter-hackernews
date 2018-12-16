import 'dart:async';

import 'package:news/src/domain/models/item_model.dart';
import 'package:news/src/use_cases/stories/fetch_item_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_top_stories_ids_use_case.dart';

class StoriesViewModel {
  StoriesViewModel(this._fetchTopStoriesIdsUseCase, this._fetchItemUseCase);

  final FetchTopStoriesIdsUseCase _fetchTopStoriesIdsUseCase;
  final FetchItemUseCase _fetchItemUseCase;

  Future<List<int>> _topIdsCache;
  final _itemsCache = Map<int, Future<ItemModel>>();

  Future<List<int>> fetchTopIds() async {
    return _topIdsCache = (_topIdsCache ?? _fetchTopStoriesIdsUseCase.execute());
  }

  Future<ItemModel> fetchItem(int id) {
    return _itemsCache[id] = (_itemsCache[id] ?? _fetchItemUseCase.execute(id));
  }
}
