import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:news/src/data/mappers/item_model_mappers.dart';
import 'package:news/src/domain/providers/api_provider.dart';
import 'package:news/src/domain/models/item_model.dart';

const _ROOT_URL = "https://hacker-news.firebaseio.com/v0";

class ApiProviderImpl implements ApiProvider {
  final Client client;

  ApiProviderImpl(this.client);

  @override
  Future<List<int>> fetchTopStoriesIds() async {
    final response = await client.get("$_ROOT_URL/topstories.json");
    final ids = json.decode(response.body).cast<int>();
    return ids;
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get("$_ROOT_URL/item/$id.json");
    final parsedItem = json.decode(response.body);
    return itemFromJsonMap(parsedItem);
  }
}
