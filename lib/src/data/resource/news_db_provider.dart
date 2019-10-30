import 'dart:io';

import 'package:flutter_data_fetching/src/data/model/item_model.dart';
import 'package:flutter_data_fetching/src/data/resource/base.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final newsDbProvider = NewsDbProvider();

class NewsDbProvider implements NewsSource, NewsCache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
        CREATE TABLE Items
        (
        id INTEGER PRIMARY KEY,
        by TEXT,
        type TEXT,
        time INTEGER,
        kids BLOB,
        url TEXT,
        score INTEGER,
        title TEXT,
        text TEXT,
        descendants INTEGER
        )
         """);
      },
    );
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

  @override
  void addItem(ItemModel item) async {
    db.insert(
      "Items",
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  clear() async {
    return db.delete("Items");
  }
}
