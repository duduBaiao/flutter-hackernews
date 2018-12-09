import 'dart:convert';

class ItemModel {
  final int id;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final bool deleted;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJsonMap(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        type = jsonMap['type'],
        by = jsonMap['by'],
        time = jsonMap['time'],
        text = jsonMap['text'],
        dead = jsonMap['dead'],
        deleted = jsonMap['deleted'],
        parent = jsonMap['parent'],
        kids = jsonMap['kids'],
        url = jsonMap['url'],
        score = jsonMap['score'],
        title = jsonMap['title'],
        descendants = jsonMap['descendants'];

  ItemModel.fromRowMap(Map<String, dynamic> rowMap)
      : id = rowMap['id'],
        type = rowMap['type'],
        by = rowMap['by'],
        time = rowMap['time'],
        text = rowMap['text'],
        dead = rowMap['dead'] == 1,
        deleted = rowMap['deleted'] == 1,
        parent = rowMap['parent'],
        kids = json.decode(rowMap['kids']),
        url = rowMap['url'],
        score = rowMap['score'],
        title = rowMap['title'],
        descendants = rowMap['descendants'];

  Map<String, dynamic> toRowMap() {
    return {
      "id": id,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "dead": dead ? 1 : 0,
      "deleted": deleted ? 1 : 0,
      "parent": parent,
      "kids": json.encode(kids),
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants
    };
  }
}
