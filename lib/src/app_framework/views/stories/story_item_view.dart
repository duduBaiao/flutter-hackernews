import 'package:flutter/material.dart';
import 'package:news/src/app_framework/design/widgets.dart';
import 'package:news/src/app_framework/views/stories/stories_view_model_provider.dart';
import 'package:news/src/domain/models/item_model.dart';

class StoryItemView extends StatelessWidget {
  StoryItemView({this.itemId});

  final int itemId;

  @override
  Widget build(BuildContext context) {
    final viewModel = StoriesViewModelProvider.of(context);

    return FutureBuilder(
      future: viewModel.fetchItem(itemId),
      builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
        if (!itemSnapshot.hasData) {
          return loadingTile();
        }
        return _storyItem(itemSnapshot.data);
      },
    );
  }

  ListTile _storyItem(ItemModel item) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text("${item.score}"),
      trailing: Column(
        children: <Widget>[
          Icon(Icons.comment),
          Text("${item.descendants}"),
        ],
      ),
    );
  }
}
