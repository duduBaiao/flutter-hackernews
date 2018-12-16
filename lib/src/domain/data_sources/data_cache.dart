import 'package:news/src/domain/models/item_model.dart';

abstract class DataCache {
  Future<int> addItem(ItemModel item);
  clear();
}
