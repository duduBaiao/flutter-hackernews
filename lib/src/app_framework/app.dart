import 'package:flutter/material.dart';
import 'package:news/src/app_framework/views/stories/stories_view.dart';
import 'package:news/src/app_framework/views/stories/stories_view_model_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: buildStoriesView(),
    );
  }

  Widget buildStoriesView() {
    return StoriesViewModelProvider(
      child: StoriesView(),
    );
  }
}
