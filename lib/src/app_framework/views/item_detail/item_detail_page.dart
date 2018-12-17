import 'package:flutter/material.dart';
import 'package:news/src/app_framework/design/styles.dart';
import 'package:news/src/app_framework/design/widgets.dart';
import 'package:news/src/app_framework/views/item_detail/item_detail_scoped_model.dart';
import 'package:news/src/domain/models/item_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemDetailPage extends StatelessWidget {
  ItemDetailPage({@required this.itemId});

  final int itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Detail"),
      ),
      body: _bodyBuilder(context),
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    final viewModel = ScopedModel.of<ItemDetailScopedModel>(context).viewModel;
    viewModel.fetchItemWithComments(itemId);

    return StreamBuilder(
      stream: viewModel.commentItems,
      builder: (BuildContext context, AsyncSnapshot<Map<int, Future<ItemModel>>> commentItemsSnapshot) {
        if (!commentItemsSnapshot.hasData) {
          return progressIndicator();
        }

        return _titleFutureBuilder(commentItemsSnapshot);
      },
    );
  }

  FutureBuilder<ItemModel> _titleFutureBuilder(AsyncSnapshot<Map<int, Future<ItemModel>>> commentItemsSnapshot) {
    final itemFuture = commentItemsSnapshot.data[itemId];

    return FutureBuilder(
      future: itemFuture,
      builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
        return padding(itemSnapshot.hasData ? _title(itemSnapshot.data) : Text('Loading item...'));
      },
    );
  }

  Widget _title(ItemModel item) {
    return Text(
      item.title,
      style: Styles.text.title,
    );
  }
}
