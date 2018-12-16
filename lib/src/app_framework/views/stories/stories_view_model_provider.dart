import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:news/src/use_cases/stories/clear_stories_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_item_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_top_stories_ids_use_case.dart';
import 'package:news/src/view_models/stories_view_model.dart';

class StoriesViewModelProvider extends InheritedWidget {
  StoriesViewModelProvider({Key key, Widget child})
      : viewModel = StoriesViewModel(
          _fetchTopStoriesIdsUseCase(),
          _fetchItemUseCase(),
          _clearStoriesUseCase(),
        ),
        super(key: key, child: child);

  final StoriesViewModel viewModel;

  static FetchTopStoriesIdsUseCase _fetchTopStoriesIdsUseCase() =>
      Injector.getInjector().get<FetchTopStoriesIdsUseCase>();

  static FetchItemUseCase _fetchItemUseCase() => Injector.getInjector().get<FetchItemUseCase>();

  static ClearStoriesUseCase _clearStoriesUseCase() => Injector.getInjector().get<ClearStoriesUseCase>();

  @override
  bool updateShouldNotify(_) => true;

  static StoriesViewModel of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesViewModelProvider) as StoriesViewModelProvider).viewModel;
  }
}
