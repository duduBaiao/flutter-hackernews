import 'package:flutter/material.dart';
import 'package:news/src/app_framework/views/page_navigator.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'News!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: PageNavigator().onGenerateRoute,
      );
}
