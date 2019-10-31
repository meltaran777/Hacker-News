import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/bloc/stories/stories_bloc.dart';
import 'package:flutter_data_fetching/src/bloc/stories/stories_bloc_provider.dart';
import 'package:flutter_data_fetching/src/ui/widget/news_list_tile.dart';
import 'package:flutter_data_fetching/src/ui/widget/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsBloc = StoriesBlockProvider.of(context);
    return buildList(newsBloc);
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Refresh(
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                int itemId = snapshot.data[index];
                bloc.fetchItem(itemId);
                return NewsListTile(
                  itemId: itemId,
                );
              }),
        );
      },
    );
  }
}
