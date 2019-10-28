import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/ui/widget/news_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: NewsList(),
    );
  }
}
