import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:news/src/data/mappers/item_model_mappers.dart';
import 'package:news/src/domain/data_sources/api_data_source.dart';
import 'package:news/src/domain/models/item_model.dart';

const _ROOT_URL = "https://hacker-news.firebaseio.com/v0";

class ApiDataSourceImpl implements ApiDataSource {
  final Client _client;

  ApiDataSourceImpl(this._client);

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
