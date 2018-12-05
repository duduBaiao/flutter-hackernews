import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:news/src/models/item_model.dart';

const _ROOT_URL = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider {
  Client client = Client();

  Future<List<dynamic>> fetchTopIds() async {
    final response = await client.get("$_ROOT_URL/topstories.json");
    final ids = json.decode(response.body);
    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get("$_ROOT_URL/item/$id.json");
    final parsedItem = json.decode(response.body);
    return ItemModel.fromJson(parsedItem);
  }
}
