import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:news/src/data_sources/news_api_provider.dart';

void main() {
  test('should fetch top ids', () async {
    final mockClient = MockClient((request) async {
      final body = json.encode([1, 2, 3, 4]);
      return Response(body, 200);
    });

    final newsApiProvider = NewsApiProvider();
    newsApiProvider.client = mockClient;

    final ids = await newsApiProvider.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('should fetch item', () async {
    final mockClient = MockClient((request) async {
      final item = {'id': 123};
      return Response(json.encode(item), 200);
    });

    final newsApiProvider = NewsApiProvider();
    newsApiProvider.client = mockClient;

    final item = await newsApiProvider.fetchItem(123);

    expect(item.id, 123);
  });
}
