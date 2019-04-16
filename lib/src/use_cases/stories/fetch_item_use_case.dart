import 'dart:async';

import 'package:news/src/domain/models/item_model.dart';
import 'package:news/src/domain/repositories/news_repository.dart';

class FetchItemUseCase {
  FetchItemUseCase(this._repository);

  final NewsRepository _repository;

  Future<ItemModel> execute(int id) => _repository.fetchItem(id);
}
