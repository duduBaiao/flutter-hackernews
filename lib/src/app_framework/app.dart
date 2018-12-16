import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:news/src/app_framework/views/page_navigator.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageNavigator _pageNavigator = Injector.getInjector().get<PageNavigator>();

    return MaterialApp(
      title: 'News!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _pageNavigator.onGenerateRoute,
    );
  }
}
