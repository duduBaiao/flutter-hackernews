import 'dart:io';

import 'package:news/src/domain/providers/db_provider.dart';
import 'package:news/src/domain/models/item_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:news/src/data/mappers/item_model_mappers.dart';

class DbProviderImpl implements DbProvider {
  DbProviderImpl() {
    init();
  }

  Database database;

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");

    database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) {
    db.execute("""
      create table items
        (
        id integer primary key,
        type text,
        by text,
        time integer,
        text text,
        dead integer,
        deleted integer,
        parent integer,
        kids blob,
        url text,
        score integer,
        title text,
        descendants integer
        )
    """);
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final results = await database.query(
      'items',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.length > 0) {
      return itemFromRowMap(results.first);
    }

    return null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    return database.insert('items', rowMapFromItem(item));
  }

  @override
  Future<List<int>> fetchTopStoriesIds() {
    return null;
  }
}
