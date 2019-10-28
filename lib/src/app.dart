import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/bloc/stories_bloc_provider.dart';
import 'package:flutter_data_fetching/src/ui/screen/home/home_screen.dart';
import 'package:flutter_data_fetching/src/ui/screen/news_details/news_details.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesBlockProvider(
      child: MaterialApp(
        title: 'News!',
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final itemId = int.parse(settings.name.replaceFirst('/', ''));
          return NewsDetailsScreen(
              itemId: itemId,
          );
        },
      );
    }
  }
}
