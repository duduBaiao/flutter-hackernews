import 'package:flutter/material.dart';
import 'package:news/src/app_framework/design/widgets.dart';
import 'package:news/src/app_framework/views/page_navigator.dart';
import 'package:news/src/app_framework/views/stories/stories_scoped_model.dart';
import 'package:news/src/app_framework/views/stories/story_item_widget.dart';
import 'package:news/src/view_models/stories_view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class StoriesPage extends StatelessWidget {
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
    final viewModel = ScopedModel.of<StoriesScopedModel>(context).viewModel;
    viewModel.fetchTopIds();

    return StreamBuilder(
      stream: viewModel.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> topIdsSnapshot) {
        return (!topIdsSnapshot.hasData) ? progressIndicator() : _list(context, viewModel, topIdsSnapshot);
      },
    );
  }

  Widget _list(BuildContext context, StoriesViewModel viewModel, AsyncSnapshot<List<int>> topIdsSnapshot) {
    final pageNavigator = ScopedModel.of<PageNavigatorScopedModel>(context).pageNavigator;

    return _refreshIndicator(
      viewModel,
      ListView.separated(
        itemCount: topIdsSnapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return StoryItemWidget(
            viewModel: viewModel,
            itemId: topIdsSnapshot.data[index],
            pageNavigator: pageNavigator,
          );
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
