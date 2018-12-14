import 'package:flutter/material.dart';
import 'package:news/src/app_framework/views/stories/stories_view_model_provider.dart';
import 'package:news/src/domain/models/item_model.dart';

class StoryWidget extends StatelessWidget {
  final int itemId;

  StoryWidget({this.itemId});

  @override
  Widget build(BuildContext context) {
    final viewModel = StoriesViewModelProvider.of(context);

    return StreamBuilder(
      stream: viewModel.items,
      builder: (BuildContext context, AsyncSnapshot<Map<int, Future<ItemModel>>> itemsSnapshot) {
        if (!itemsSnapshot.hasData) {
          return title('Still loading stream...');
        }

        return FutureBuilder(
          future: itemsSnapshot.data[itemId],
          builder: (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return title('Loading item $itemId...');
            }

            return title(itemSnapshot.data.title);
          },
        );
      },
    );
  }

  Widget title(String title) {
    return Container(
      height: 80,
      child: Text(title),
    );
  }
}
