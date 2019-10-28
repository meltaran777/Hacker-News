import 'package:flutter_data_fetching/src/data/model/item_model.dart';
import 'package:flutter_data_fetching/src/data/resource/base.dart';
import 'package:flutter_data_fetching/src/data/resource/news_api_provider.dart';
import 'package:flutter_data_fetching/src/data/resource/news_db_provider.dart';

class NewsRepository {
  List<NewsSource> sources = <NewsSource>[
    newsDbProvider,
    newsApiProvider,
  ];
  List<NewsCache> caches = <NewsCache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() async {
    for (var source in sources) {
      List<int> ids = await source.fetchTopIds();
      if (ids != null) {
        return ids;
      }
    }
    return null;
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    NewsSource source;
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }
    for (var cache in caches) {
      if (item != null) cache.addItem(item);
    }
    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}
