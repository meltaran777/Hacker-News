import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/data/model/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  const Comment({Key key, this.itemId, this.itemMap, this.depth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap[itemId],
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (!snapshot.hasData) {
            return Text('Comment Loading... ');
          }

          final children = <Widget>[
            ListTile(
              title: Text(snapshot.data.text),
              subtitle: snapshot.data.by != ''
                  ? Text(snapshot.data.by)
                  : Text('Deleted'),
            ),
            Divider(),
          ];

          var kids = snapshot.data.kids;

          if (kids != null)
            kids.forEach((kidId) {
              children.add(Comment(
                itemId: kidId,
                itemMap: itemMap,
                depth: depth + 1,
              ));
            });

          return Column(children: children);
        });
  }
}
