import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:news/src/use_cases/stories/clear_stories_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_item_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_top_stories_ids_use_case.dart';
import 'package:news/src/view_models/stories_view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class StoriesScopedModel extends Model {
  StoriesScopedModel()
      : viewModel = StoriesViewModel(
          _fetchTopStoriesIdsUseCase(),
          _fetchItemUseCase(),
          _clearStoriesUseCase(),
        );

  final StoriesViewModel viewModel;

  static FetchTopStoriesIdsUseCase _fetchTopStoriesIdsUseCase() =>
      Injector.getInjector().get<FetchTopStoriesIdsUseCase>();

  static FetchItemUseCase _fetchItemUseCase() => Injector.getInjector().get<FetchItemUseCase>();

  static ClearStoriesUseCase _clearStoriesUseCase() =>
      Injector.getInjector().get<ClearStoriesUseCase>();
}
