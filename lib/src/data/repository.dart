import 'dart:async';

import 'package:news/src/data/providers/api_provider.dart';
import 'package:news/src/data/providers/cache_provider.dart';
import 'package:news/src/data/providers/db_provider.dart';
import 'package:news/src/data/providers/source_provider.dart';
import 'package:news/src/domain/models/item_model.dart';

class Repository {
  List<SourceProvider> sources = [dbProvider, apiProvider];

  List<CacheProvider> caches = [dbProvider];

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;

    for (SourceProvider source in sources) {
      item = await source.fetchItem(id);

      if (item != null) {
        for (CacheProvider cache in caches) {
          cache.addItem(item);
        }

        break;
      }
    }

    return item;
  }
}
