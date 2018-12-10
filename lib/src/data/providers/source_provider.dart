import 'package:news/src/domain/models/item_model.dart';

abstract class SourceProvider {
  Future<List<int>> fetchTopIds();

  Future<ItemModel> fetchItem(int id);
}
