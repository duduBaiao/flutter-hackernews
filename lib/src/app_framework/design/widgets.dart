import 'package:flutter/material.dart';
import 'package:news/src/app_framework/design/metrics.dart';

Widget progressIndicator() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget loadingTile() {
  return Container(
    height: Metrics.list.tile.defaultHeight,
    child: ListTile(
      title: Container(
        height: 36.0,
        color: Colors.grey[100],
      ),
    ),
  );
}
