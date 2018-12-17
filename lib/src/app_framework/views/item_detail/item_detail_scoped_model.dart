import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:news/src/use_cases/stories/fetch_item_use_case.dart';
import 'package:news/src/view_models/item_detail_view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemDetailScopedModel extends Model {
  ItemDetailScopedModel()
      : viewModel = ItemDetailViewModel(
          _fetchItemUseCase(),
        );

  final ItemDetailViewModel viewModel;

  static FetchItemUseCase _fetchItemUseCase() => Injector.getInjector().get<FetchItemUseCase>();
}
