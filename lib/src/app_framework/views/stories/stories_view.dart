import 'package:flutter/material.dart';
import 'package:news/src/app_framework/views/stories/stories_view_model_provider.dart';
import 'package:news/src/app_framework/views/stories/story_widget.dart';
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
        builder: (BuildContext context, AsyncSnapshot<List<int>> listSnapshot) {
          return (!listSnapshot.hasData) ? _progressIndicator() : _list(listSnapshot, viewModel);
        });
  }

  ListView _list(AsyncSnapshot<List<int>> listSnapshot, StoriesViewModel viewModel) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final itemId = listSnapshot.data[index];
        viewModel.fetchItem(itemId);

        return StoryWidget(itemId: itemId);
      },
      itemCount: listSnapshot.data.length,
    );
  }

  Widget _progressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
