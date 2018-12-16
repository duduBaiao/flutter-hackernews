import 'dart:async';

import 'package:news/src/domain/models/item_model.dart';

abstract class NewsRepository {
  Future<List<int>> fetchTopStoriesIds();

  Future<ItemModel> fetchItem(int id);

  Future<int> clearStories();
}
