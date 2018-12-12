import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:news/src/app_framework/data_sources/api_data_source.dart';

void main() {
  MockClient createMockClient(body) {
    return MockClient((request) async {
      return Response(json.encode(body), 200);
    });
  }

  test('should fetch top ids', () async {
    // given
    final client = createMockClient([1, 2, 3, 4]);
    final apiProvider = ApiDataSourceImpl(client);

    // when
    final ids = await apiProvider.fetchTopStoriesIds();

    // then
    expect(ids, [1, 2, 3, 4]);
  });

  test('should fetch item', () async {
    // given
    final client = createMockClient({'id': 123});
    final apiProvider = ApiDataSourceImpl(client);

    // when
    final item = await apiProvider.fetchItem(123);

    // then
    expect(item.id, 123);
  });
}
