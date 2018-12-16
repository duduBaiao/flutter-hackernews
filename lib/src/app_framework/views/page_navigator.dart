import 'package:flutter/material.dart';
import 'package:news/src/app_framework/views/item_detail/item_detail_page.dart';
import 'package:news/src/app_framework/views/stories/stories_page.dart';
import 'package:news/src/app_framework/views/stories/stories_view_model_provider.dart';

class PageNavigator {
  static const _ITEM_DETAIL_PAGE = "/item_detail/";

  pushItemDetailPage(BuildContext context, int itemId) {
    Navigator.pushNamed(context, "$_ITEM_DETAIL_PAGE$itemId");
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name.startsWith(_ITEM_DETAIL_PAGE)) {
      int itemId = _extractIntParam(settings);
      return _itemDetailPageRoute(itemId);
    }
    return _storiesPageRoute();
  }

  MaterialPageRoute _storiesPageRoute() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return _storiesPage();
    });
  }

  Widget _storiesPage() {
    return StoriesViewModelProvider(
      child: StoriesPage(pageNavigator: this),
    );
  }

  MaterialPageRoute _itemDetailPageRoute(int itemId) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return ItemDetailPage(itemId: itemId);
    });
  }

  int _extractIntParam(RouteSettings settings) {
    return int.parse(settings.name.split("/").last);
  }
}
