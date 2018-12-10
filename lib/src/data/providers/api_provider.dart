import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:news/src/data/providers/source_provider.dart';
import 'package:news/src/domain/models/item_model.dart';

const _ROOT_URL = "https://hacker-news.firebaseio.com/v0";

class ApiProvider implements SourceProvider {
  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get("$_ROOT_URL/topstories.json");
    final ids = json.decode(response.body).cast<int>();
    return ids;
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get("$_ROOT_URL/item/$id.json");
    final parsedItem = json.decode(response.body);
    return ItemModel.fromJsonMap(parsedItem);
  }
}

final apiProvider = ApiProvider();
