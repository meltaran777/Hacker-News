
import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/bloc/comment/comment_bloc.dart';

class CommentBlockProvider extends InheritedWidget {
  final CommentBloc bloc;

  CommentBlockProvider({Key key, Widget child})
      : bloc = CommentBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static CommentBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CommentBlockProvider)
    as CommentBlockProvider)
        .bloc;
  }
}