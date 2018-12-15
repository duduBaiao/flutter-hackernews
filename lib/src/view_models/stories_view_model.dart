import 'dart:async';

import 'package:news/src/domain/models/item_model.dart';
import 'package:news/src/use_cases/stories/fetch_item_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_top_stories_ids_use_case.dart';
import 'package:rxdart/rxdart.dart';

class StoriesViewModel {
  final FetchTopStoriesIdsUseCase _fetchTopStoriesIdsUseCase;
  final FetchItemUseCase _fetchItemUseCase;

  final _topIds = BehaviorSubject<List<int>>();

  final _itemIdsInput = PublishSubject<int>();

  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  StoriesViewModel(this._fetchTopStoriesIdsUseCase, this._fetchItemUseCase) {
    _itemIdsInput.stream.transform(_idsToItemsTransformer()).pipe(_itemsOutput);
  }

  Observable<List<int>> get topIds => _topIds.stream;

  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  fetchTopIds() async {
    final ids = await _fetchTopStoriesIdsUseCase.execute();
    _topIds.sink.add(ids);
  }

  fetchItem(int id) {
    _itemIdsInput.sink.add(id);
  }

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>> _idsToItemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _fetchItemUseCase.execute(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIds.close();
    _itemIdsInput.close();
    _itemsOutput.close();
  }
}
