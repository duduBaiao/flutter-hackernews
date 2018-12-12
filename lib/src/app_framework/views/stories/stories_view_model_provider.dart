import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:news/src/domain/repositories/news_repository.dart';
import 'package:news/src/view_models/stories_view_model.dart';

class StoriesViewModelProvider extends InheritedWidget {
  final StoriesViewModel viewModel;

  StoriesViewModelProvider({Key key, Widget child})
      : viewModel = StoriesViewModel(injectedRepository()),
        super(key: key, child: child);

  static NewsRepository injectedRepository() => Injector.getInjector().get<NewsRepository>();

  @override
  bool updateShouldNotify(_) => true;

  static StoriesViewModel of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesViewModelProvider)
            as StoriesViewModelProvider)
        .viewModel;
  }
}
