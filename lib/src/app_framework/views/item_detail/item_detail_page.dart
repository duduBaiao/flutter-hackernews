import 'package:flutter/material.dart';
import 'package:news/src/app_framework/views/item_detail/item_detail_scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemDetailPage extends StatelessWidget {
  ItemDetailPage({@required this.itemId});

  final int itemId;

  @override
  Widget build(BuildContext context) {
    final viewModel = ScopedModel.of<ItemDetailScopedModel>(context).viewModel;
    viewModel.fetchItemWithComments(itemId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Item Detail"),
      ),
      body: Text("Item id: $itemId"),
    );
  }
}
