import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:news/src/use_cases/stories/fetch_item_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_top_stories_ids_use_case.dart';
import 'package:news/src/view_models/stories_view_model.dart';

class StoriesViewModelProvider extends InheritedWidget {
  final StoriesViewModel viewModel;

  StoriesViewModelProvider({Key key, Widget child})
      : viewModel = StoriesViewModel(fetchTopStoriesIds(), fetchItem()),
        super(key: key, child: child);

  static FetchTopStoriesIdsUseCase fetchTopStoriesIds() => Injector.getInjector().get<FetchTopStoriesIdsUseCase>();

  static FetchItemUseCase fetchItem() => Injector.getInjector().get<FetchItemUseCase>();

  @override
  bool updateShouldNotify(_) => true;

  static StoriesViewModel of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesViewModelProvider) as StoriesViewModelProvider).viewModel;
  }
}
