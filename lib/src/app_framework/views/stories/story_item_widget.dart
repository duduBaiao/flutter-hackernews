import 'package:flutter/material.dart';
import 'package:news/src/app_framework/design/widgets.dart';
import 'package:news/src/app_framework/views/page_navigator.dart';
import 'package:news/src/app_framework/views/stories/stories_view_model_provider.dart';
import 'package:news/src/domain/models/item_model.dart';

class StoryItemWidget extends StatelessWidget {
  StoryItemWidget({@required this.itemId, @required this.pageNavigator});

  final int itemId;
  final PageNavigator pageNavigator;

  @override
  Widget build(BuildContext context) {
    final viewModel = StoriesViewModelProvider.of(context);

    return FutureBuilder(
      future: viewModel.fetchItem(itemId),
      builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
        if (!itemSnapshot.hasData) {
          return loadingTile();
        }
        return _storyItem(context, itemSnapshot.data);
      },
    );
  }

  ListTile _storyItem(BuildContext context, ItemModel item) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text("${item.score}"),
      trailing: Column(
        children: <Widget>[
          Icon(Icons.comment),
          Text("${item.descendants}"),
        ],
      ),
      onTap: () {
        pageNavigator.pushItemDetailPage(context, item.id);
      },
    );
  }
}
