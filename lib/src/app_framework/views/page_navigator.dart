import 'package:flutter/material.dart';
import 'package:news/src/app_framework/views/item_detail/item_detail_page.dart';
import 'package:news/src/app_framework/views/item_detail/item_detail_scoped_model.dart';
import 'package:news/src/app_framework/views/stories/stories_page.dart';
import 'package:news/src/app_framework/views/stories/stories_scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class PageNavigator {
  static const _ITEM_DETAIL_PAGE = "/item_detail/";

  pushItemDetailPage(BuildContext context, int itemId) {
    Navigator.pushNamed(context, "$_ITEM_DETAIL_PAGE$itemId");
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    var pageWidget;

    if (settings.name.startsWith(_ITEM_DETAIL_PAGE)) {
      int itemId = _extractIntParam(settings);
      pageWidget = _itemDetailPageRoute(itemId);
    } else {
      pageWidget = _storiesPage();
    }
    return _pageRoute(pageWidget);
  }

  MaterialPageRoute _pageRoute(Widget child) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return ScopedModel<PageNavigatorScopedModel>(
        model: PageNavigatorScopedModel(pageNavigator: this),
        child: child,
      );
    });
  }

  Widget _storiesPage() {
    return ScopedModel<StoriesScopedModel>(
      model: StoriesScopedModel(),
      child: StoriesPage(),
    );
  }

  Widget _itemDetailPageRoute(int itemId) {
    return ScopedModel<ItemDetailScopedModel>(
      model: ItemDetailScopedModel(),
      child: ItemDetailPage(itemId: itemId),
    );
  }

  int _extractIntParam(RouteSettings settings) {
    return int.parse(settings.name.split("/").last);
  }
}

class PageNavigatorScopedModel extends Model {
  PageNavigatorScopedModel({@required this.pageNavigator});

  final PageNavigator pageNavigator;
}
