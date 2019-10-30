import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/bloc/comment/comment_bloc.dart';
import 'package:flutter_data_fetching/src/bloc/comment/comment_bloc_provider.dart';
import 'package:flutter_data_fetching/src/data/model/item_model.dart';
import 'package:flutter_data_fetching/src/ui/widget/comment.dart';

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
          if (!snapshot.hasData) {
            return Text('Loading...');
          }
          final itemFuture = snapshot.data[itemId];
          return FutureBuilder(
              future: itemFuture,
              builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return Text('Loading...');
                }
                return _buildList(itemSnapshot.data, snapshot.data);
              });
        });
  }

  Widget _buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];

    final commentsList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();

    children.add(_buildTitle(item.title));
    children.addAll(commentsList);

    return ListView(children: children);
  }

  Widget _buildTitle(String title) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
