import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/bloc/comment/comment_bloc_provider.dart';
import 'package:flutter_data_fetching/src/bloc/stories/stories_bloc_provider.dart';
import 'package:flutter_data_fetching/src/ui/screen/home/home_screen.dart';
import 'package:flutter_data_fetching/src/ui/screen/news_details/news_details.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentBlockProvider(
      child: StoriesBlockProvider(
        child: MaterialApp(
          title: 'News!',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final bloc = StoriesBlockProvider.of(context);
          bloc.fetchTopIds();
          return HomeScreen();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentBloc = CommentBlockProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));
          commentBloc.fetchItemWithComments(itemId);
          return NewsDetailsScreen(
            itemId: itemId,
          );
        },
      );
    }
  }
}
