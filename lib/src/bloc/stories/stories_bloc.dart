import 'package:flutter_data_fetching/src/data/model/item_model.dart';
import 'package:flutter_data_fetching/src/data/resource/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _repository = NewsRepository();

  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  Observable<List<int>> get topIds => _topIds.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  clearCache(){
    return _repository.clearCache();
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
