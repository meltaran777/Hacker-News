import 'package:flutter_data_fetching/src/data/model/item_model.dart';

abstract class NewsSource {
  Future<List<int>> fetchTopIds();

  Future<ItemModel> fetchItem(int id);
}

abstract class NewsCache {
  void addItem(ItemModel item);
  Future<int> clear();
}
