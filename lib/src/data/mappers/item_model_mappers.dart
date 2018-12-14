import 'dart:convert';

import 'package:news/src/domain/models/item_model.dart';

ItemModel itemFromJsonMap(Map<String, dynamic> jsonMap) {
  return ItemModel(
      id: jsonMap['id'],
      type: jsonMap['type'],
      by: jsonMap['by'],
      time: jsonMap['time'],
      text: jsonMap['text'] ?? '',
      dead: jsonMap['dead'] ?? false,
      deleted: jsonMap['deleted'] ?? false,
      parent: jsonMap['parent'],
      kids: jsonMap['kids'] ?? [],
      url: jsonMap['url'],
      score: jsonMap['score'],
      title: jsonMap['title'],
      descendants: jsonMap['descendants'] ?? 0);
}

ItemModel itemFromRowMap(Map<String, dynamic> rowMap) {
  return ItemModel(
      id: rowMap['id'],
      type: rowMap['type'],
      by: rowMap['by'],
      time: rowMap['time'],
      text: rowMap['text'],
      dead: rowMap['dead'] == 1,
      deleted: rowMap['deleted'] == 1,
      parent: rowMap['parent'],
      kids: json.decode(rowMap['kids']),
      url: rowMap['url'],
      score: rowMap['score'],
      title: rowMap['title'],
      descendants: rowMap['descendants']);
}

Map<String, dynamic> rowMapFromItem(ItemModel item) {
  return {
    "id": item.id,
    "type": item.type,
    "by": item.by,
    "time": item.time,
    "text": item.text,
    "dead": item.dead ? 1 : 0,
    "deleted": item.deleted ? 1 : 0,
    "parent": item.parent,
    "kids": json.encode(item.kids),
    "url": item.url,
    "score": item.score,
    "title": item.title,
    "descendants": item.descendants
  };
}
