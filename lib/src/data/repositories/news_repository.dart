import 'dart:async';

import 'package:news/src/domain/data_sources/api_data_source.dart';
import 'package:news/src/domain/data_sources/db_data_source.dart';
import 'package:news/src/domain/models/item_model.dart';
import 'package:news/src/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final DbDataSource _dbDataSource;
  final ApiDataSource _apiDataSource;

  NewsRepositoryImpl(this._dbDataSource, this._apiDataSource);

  Future<List<int>> fetchTopStoriesIds() => _apiDataSource.fetchTopStoriesIds();

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item = await _dbDataSource.fetchItem(id);

    if (item == null) {
      item = await _apiDataSource.fetchItem(id);

      if (item != null) {
        _dbDataSource.addItem(item);
      }
    }

    return item;
  }

  @override
  Future<int> clearStories() {
    return _dbDataSource.clear();
  }
}
