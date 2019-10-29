import 'dart:async';

import 'package:flutter_data_fetching/src/data/model/item_model.dart';
import 'package:flutter_data_fetching/src/data/resource/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class CommentBloc {
  final _repository = NewsRepository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }

  StreamTransformer<int, Map<int, Future<ItemModel>>> _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (
        cache,
        int id,
        index,
      ) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        cache[id].then((ItemModel item) {
          if (item.kids != null)
            item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }
}
