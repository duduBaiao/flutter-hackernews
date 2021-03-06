import 'dart:async';

import 'package:news/src/data/data_sources/api_data_source.dart';
import 'package:news/src/data/data_sources/db_data_source.dart';
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
  clearStories() async => await _dbDataSource.clear();
}
