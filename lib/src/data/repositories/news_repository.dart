import 'dart:async';

import 'package:news/src/domain/data_sources/api_data_source.dart';
import 'package:news/src/domain/data_sources/data_cache.dart';
import 'package:news/src/domain/data_sources/data_source.dart';
import 'package:news/src/domain/data_sources/db_data_source.dart';
import 'package:news/src/domain/models/item_model.dart';
import 'package:news/src/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final DbDataSource _dbDataSource;
  final ApiDataSource _apiDataSource;

  NewsRepositoryImpl(this._dbDataSource, this._apiDataSource);

  Future<List<int>> fetchTopStoriesIds() => _apiDataSource.fetchTopStoriesIds();

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;

    for (DataSource source in _sources()) {
      item = await source.fetchItem(id);

      if (item != null) {
        for (DataCache cache in _caches()) {
          cache.addItem(item);
        }

        break;
      }
    }

    return item;
  }

  List<DataCache> _caches() => [_dbDataSource];

  List<DataSource> _sources() => [_dbDataSource, _apiDataSource];
}
