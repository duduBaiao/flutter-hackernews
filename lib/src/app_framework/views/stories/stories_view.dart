import 'package:flutter/material.dart';
import 'package:news/src/app_framework/design/widgets.dart';
import 'package:news/src/app_framework/views/stories/stories_view_model_provider.dart';
import 'package:news/src/app_framework/views/stories/story_item_view.dart';
import 'package:news/src/view_models/stories_view_model.dart';

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
        return (!topIdsSnapshot.hasData) ? progressIndicator() : _list(viewModel, topIdsSnapshot);
      },
    );
  }

  Widget _list(StoriesViewModel viewModel, AsyncSnapshot<List<int>> topIdsSnapshot) {
    return _refreshIndicator(
      viewModel,
      ListView.separated(
        itemCount: topIdsSnapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return StoryItemView(itemId: topIdsSnapshot.data[index]);
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }

  Widget _refreshIndicator(StoriesViewModel viewModel, Widget child) {
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await viewModel.clearStories();
        await viewModel.fetchTopIds();
      },
    );
  }
}
