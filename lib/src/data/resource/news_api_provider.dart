import 'dart:convert';

import 'package:flutter_data_fetching/src/data/model/item_model.dart';
import 'package:flutter_data_fetching/src/data/resource/base.dart';
import 'package:http/http.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';
final newsApiProvider = NewsApiProvider();

class NewsApiProvider implements NewsSource{
  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_root/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final Response response = await client.get('$_root/item/$id.json');
    return ItemModel.fromJsonMap(json.decode(response.body));
  }
}
