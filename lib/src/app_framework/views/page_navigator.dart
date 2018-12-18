import 'package:flutter/material.dart';
import 'package:news/src/app_framework/views/item_detail/item_detail_page.dart';
import 'package:news/src/app_framework/views/item_detail/item_detail_scoped_model.dart';
import 'package:news/src/app_framework/views/stories/stories_page.dart';
import 'package:news/src/app_framework/views/stories/stories_scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class PageNavigator {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return _pageRoute(child: _storiesPage());
  }

  pushItemDetailPage(BuildContext context, int itemId) {
    Navigator.push(
      context,
      _pageRoute(child: _itemDetailPage(itemId)),
    );
  }

  MaterialPageRoute _pageRoute({Widget child}) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return ScopedModel<PageNavigatorScopedModel>(
          model: PageNavigatorScopedModel(pageNavigator: this),
          child: child,
        );
      },
    );
  }

  Widget _storiesPage() {
    return ScopedModel<StoriesScopedModel>(
      model: StoriesScopedModel(),
      child: StoriesPage(),
    );
  }

  Widget _itemDetailPage(int itemId) {
    return ScopedModel<ItemDetailScopedModel>(
      model: ItemDetailScopedModel(),
      child: ItemDetailPage(itemId: itemId),
    );
  }
}

class PageNavigatorScopedModel extends Model {
  PageNavigatorScopedModel({@required this.pageNavigator});

  final PageNavigator pageNavigator;
}
