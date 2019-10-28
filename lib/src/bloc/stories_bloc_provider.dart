
import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/bloc/stories_bloc.dart';

class StoriesBlockProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesBlockProvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesBlockProvider)
            as StoriesBlockProvider)
        .bloc;
  }
}
