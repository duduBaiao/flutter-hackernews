import 'dart:async';

import 'package:news/src/domain/models/item_model.dart';
import 'package:news/src/use_cases/stories/fetch_item_use_case.dart';
import 'package:rxdart/rxdart.dart';

class ItemDetailViewModel {
  ItemDetailViewModel(this._fetchItemUseCase);

  final FetchItemUseCase _fetchItemUseCase;

  final _commentItems = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _commentItemsCache = Map<int, Future<ItemModel>>();

  Observable<Map<int, Future<ItemModel>>> get commentItems => _commentItems.stream;

  fetchItemWithComments(int itemId) async {
    _commentItemsCache[itemId] ??= _fetchItemUseCase.execute(itemId);
    _commentItems.sink.add(_commentItemsCache);

    _commentItemsCache[itemId].then((ItemModel item) {
      item.kids.forEach((kidId) => fetchItemWithComments(kidId));
    });
  }

  dispose() {
    _commentItems.close();
  }
}
