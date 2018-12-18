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

        return _bodyFutureBuilder(commentItemsSnapshot);
      },
    );
  }

  FutureBuilder<ItemModel> _bodyFutureBuilder(AsyncSnapshot<Map<int, Future<ItemModel>>> commentItemsSnapshot) {
    final itemFuture = commentItemsSnapshot.data[itemId];

    return FutureBuilder(
      future: itemFuture,
      builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
        if (!itemSnapshot.hasData) {
          return padding(Text('Loading item...'));
        }

        return _commentsList(itemSnapshot.data, commentItemsSnapshot.data);
      },
    );
  }

  Widget _commentsList(ItemModel item, Map<int, Future<ItemModel>> commentItems) {
    final children = <Widget>[
      padding(_title(item)),
      lrPadding(Text('Comments:')),
      spacer(),
    ];

    _addComments(item, commentItems, children);

    return ListView(children: children);
  }

  Widget _title(ItemModel item) {
    return Text(
      item.title,
      style: Styles.text.title,
    );
  }

  void _addComments(ItemModel item, Map<int, Future<ItemModel>> commentItems, List<Widget> children) {
    final commentList = item.kids.map((kidId) => _comment(kidId, commentItems)).toList();
    children.addAll(commentList);
  }

  Widget _comment(int itemId, Map<int, Future<ItemModel>> commentItems) {
    final itemFuture = commentItems[itemId];

    return FutureBuilder(
      future: itemFuture,
      builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
        if (!itemSnapshot.hasData) {
          return padding(Text(''));
        }

        final item = itemSnapshot.data;

        final children = <Widget>[
          lrbPadding(Text(item.text)),
        ];

        _addComments(item, commentItems, children);

        return Column(
          children: children,
          crossAxisAlignment: CrossAxisAlignment.start,
        );
      },
    );
  }
}
