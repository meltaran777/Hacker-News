import 'package:flutter/material.dart';
import 'package:flutter_data_fetching/src/bloc/stories/stories_bloc.dart';
import 'package:flutter_data_fetching/src/bloc/stories/stories_bloc_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  const Refresh({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoriesBloc bloc = StoriesBlockProvider.of(context);
    return RefreshIndicator(
      child: this.child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
