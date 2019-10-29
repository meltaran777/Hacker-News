import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/bloc/comment/comment_bloc.dart';
import 'package:flutter_data_fetching/src/bloc/comment/comment_bloc_provider.dart';
import 'package:flutter_data_fetching/src/data/model/item_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  final int itemId;

  const NewsDetailsScreen({Key key, this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentBloc = CommentBlockProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: buildBody(commentBloc),
    );
  }

  Widget buildBody(CommentBloc bloc) {
    return StreamBuilder<Map<int, Future<ItemModel>>>(
        stream: bloc.itemWithComments,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          return Text('Details screen body $itemId');
        });
  }
}
