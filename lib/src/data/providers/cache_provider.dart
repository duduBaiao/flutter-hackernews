import 'package:news/src/domain/models/item_model.dart';

abstract class CacheProvider {
  Future<int> addItem(ItemModel item);
}
