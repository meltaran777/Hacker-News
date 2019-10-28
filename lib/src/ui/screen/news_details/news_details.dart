import 'package:flutter/material.dart';

class NewsDetailsScreen extends StatelessWidget {
  final int itemId;

  const NewsDetailsScreen({Key key, this.itemId}) : super(key: key);@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Text('Details screen body $itemId'),
    );
  }
}
