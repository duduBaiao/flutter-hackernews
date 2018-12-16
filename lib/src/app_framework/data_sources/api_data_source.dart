import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:news/src/data/data_sources/api_data_source.dart';
import 'package:news/src/data/mappers/item_model_mappers.dart';
import 'package:news/src/domain/models/item_model.dart';

class ApiDataSourceImpl implements ApiDataSource {
  static const _ROOT_URL = "https://hacker-news.firebaseio.com/v0";

  ApiDataSourceImpl(this._client);

  final Client _client;

  @override
  Future<List<int>> fetchTopStoriesIds() async {
    final response = await _client.get("$_ROOT_URL/topstories.json");
    final ids = json.decode(response.body).cast<int>();
    return ids;
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await _client.get("$_ROOT_URL/item/$id.json");
    final parsedItem = json.decode(response.body);
    return itemFromJsonMap(parsedItem);
  }
}
