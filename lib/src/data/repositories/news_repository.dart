import 'dart:async';

import 'package:news/src/domain/providers/api_provider.dart';
import 'package:news/src/domain/providers/cache_provider.dart';
import 'package:news/src/domain/providers/db_provider.dart';
import 'package:news/src/domain/providers/source_provider.dart';
import 'package:news/src/domain/models/item_model.dart';
import 'package:news/src/domain/repositories/news_repository.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class NewsRepositoryImpl implements NewsRepository {
  final DbProvider dbProvider = Injector.getInjector().get<DbProvider>();
  final ApiProvider apiProvider = Injector.getInjector().get<ApiProvider>();

  Future<List<int>> fetchTopStoriesIds() {
    return apiProvider.fetchTopStoriesIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;

    for (SourceProvider source in _sources()) {
      item = await source.fetchItem(id);

      if (item != null) {
        for (CacheProvider cache in _caches()) {
          cache.addItem(item);
        }

        break;
      }
    }

    return item;
  }

  List<CacheProvider> _caches() => [dbProvider];
  List<SourceProvider> _sources() => [dbProvider, apiProvider];
}
