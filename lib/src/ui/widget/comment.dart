import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/data/model/item_model.dart';
import 'package:flutter_data_fetching/src/ui/widget/loading_container.dart';

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
            return LoadingContainer();
          }

          final children = <Widget>[
            ListTile(
              title: buildText(snapshot.data.text),
              subtitle: snapshot.data.by != ''
                  ? Text(snapshot.data.by)
                  : Text('Deleted'),
              contentPadding: EdgeInsets.only(
                right: 16.0,
                left: depth * 16.0,
              ),
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

  Widget buildText(String text) {
    final formattedText = text
        .replaceAll('&#x27', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');
    return Text(formattedText);
  }
}
