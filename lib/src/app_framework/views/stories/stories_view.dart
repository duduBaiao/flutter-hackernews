import 'package:flutter/material.dart';
import 'package:news/src/app_framework/design/widgets.dart';
import 'package:news/src/app_framework/views/stories/stories_view_model_provider.dart';
import 'package:news/src/app_framework/views/stories/story_item_view.dart';

class StoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: _listBuilder(context),
    );
  }

  Widget _listBuilder(BuildContext context) {
    final viewModel = StoriesViewModelProvider.of(context);
    viewModel.fetchTopIds();

    return StreamBuilder(
        stream: viewModel.topIds,
        builder: (BuildContext context, AsyncSnapshot<List<int>> topIdsSnapshot) {
          return (!topIdsSnapshot.hasData) ? progressIndicator() : _list(topIdsSnapshot);
        });
  }

  ListView _list(AsyncSnapshot<List<int>> topIdsSnapshot) {
    return ListView.separated(
      itemCount: topIdsSnapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return StoryItemView(itemId: topIdsSnapshot.data[index]);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }
}
