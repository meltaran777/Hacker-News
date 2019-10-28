import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/bloc/stories_bloc_provider.dart';
import 'package:flutter_data_fetching/src/data/model/item_model.dart';
import 'package:flutter_data_fetching/src/ui/widget/loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({Key key, this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesBlockProvider.of(context);
    return StreamBuilder<Map<int, Future<ItemModel>>>(
        stream: bloc.items,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoadingContainer(),
            );
          }
          return FutureBuilder<ItemModel>(
              future: snapshot.data[itemId],
              builder: (context, itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return LoadingContainer();
                }
                return buildTile(itemSnapshot.data);
              });
        });
  }

  Widget buildTile(ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        )
      ],
    );
  }
}
