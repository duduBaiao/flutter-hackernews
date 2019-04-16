import 'dart:async';

import 'package:news/src/domain/models/item_model.dart';

abstract class DataSource {
  Future<List<int>> fetchTopStoriesIds();

  Future<ItemModel> fetchItem(int id);
}
