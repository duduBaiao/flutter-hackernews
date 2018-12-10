import 'package:flutter/material.dart';
import 'package:news/src/presentation/screens/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsList(),
    );
  }
}
