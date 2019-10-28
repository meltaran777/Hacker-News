import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/bloc/stories_bloc_provider.dart';
import 'package:flutter_data_fetching/src/ui/screen/home/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesBlockProvider(
      child: MaterialApp(
        title: 'News!',
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          );
        },
      ),
    );
  }
}
