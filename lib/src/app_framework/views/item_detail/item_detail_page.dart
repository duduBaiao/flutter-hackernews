import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:news/src/app_framework/design/metrics.dart';
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
    ];

    if (item.kids.length > 0) {
      children.addAll([
        lrPadding(Text('Comments:')),
        spacer(),
      ]);

      _addComments(item, commentItems, children, 0);
    }

    return ListView(children: children);
  }

  Widget _title(ItemModel item) {
    return Text(
      item.title,
      style: Styles.text.title,
    );
  }

  void _addComments(ItemModel item, Map<int, Future<ItemModel>> commentItems, List<Widget> children, int depth) {
    final newDepth = ++depth;
    final commentList = item.kids.map((kidId) => _comment(kidId, commentItems, newDepth)).toList();
    children.addAll(commentList);
  }

  Widget _comment(int itemId, Map<int, Future<ItemModel>> commentItems, int depth) {
    final itemFuture = commentItems[itemId];

    return FutureBuilder(
      future: itemFuture,
      builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
        if (!itemSnapshot.hasData) {
          return padding(Text(''));
        }

        final item = itemSnapshot.data;

        final children = <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: Metrics.layout.halfPadding * depth,
              right: Metrics.layout.halfPadding,
            ),
            child: Column(
              children: <Widget>[
                Padding(child: Text(item.by), padding: EdgeInsets.only(left: Metrics.layout.halfPadding)),
                HtmlView(data: "<p>${item.deleted ? 'Deleted' : item.text}</p>", padding: EdgeInsets.zero),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Divider(),
        ];

        _addComments(item, commentItems, children, depth);

        return Column(
          children: children,
          crossAxisAlignment: CrossAxisAlignment.start,
        );
      },
    );
  }
}
