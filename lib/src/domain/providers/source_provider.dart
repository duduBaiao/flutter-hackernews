import 'package:news/src/domain/models/item_model.dart';

abstract class SourceProvider {
  Future<List<int>> fetchTopStoriesIds();

  Future<ItemModel> fetchItem(int id);
}
