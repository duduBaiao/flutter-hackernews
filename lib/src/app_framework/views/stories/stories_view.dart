import 'package:flutter/material.dart';
import 'package:news/src/app_framework/views/stories/stories_view_model_provider.dart';

class StoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: listBuilder(context),
    );
  }

  Widget listBuilder(BuildContext context) {
    final viewModel = StoriesViewModelProvider.of(context);
    viewModel.fetchTopIds();

    return StreamBuilder(
        stream: viewModel.topIds,
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) {
            return Text("Still loading...");
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text('Item index $index');
              },
              itemCount: snapshot.data.length,
            );
          }
        });
  }
}
