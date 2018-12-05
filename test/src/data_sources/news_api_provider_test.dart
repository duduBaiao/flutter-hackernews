import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:news/src/data_sources/news_api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('should fetch top ids', () async {
    final newsApiProvider = NewsApiProvider();

    final mockClient = MockClient((request) async {
      final body = json.encode([1, 2, 3, 4]);
      return Response(body, 200);
    });

    newsApiProvider.client = mockClient;

    final ids = await newsApiProvider.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });
}
