import 'package:flutter/material.dart';
import 'package:news/src/app_framework/views/stories_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoriesView(),
    );
  }
}
