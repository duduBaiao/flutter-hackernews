import 'package:flutter/material.dart';
import 'package:news/src/app_framework/design/metrics.dart';

Widget loadingTitle() {
  return Container(
    height: Metrics.list.item.defaultHeight,
    child: ListTile(
      title: Container(
        height: 36.0,
        color: Colors.grey[100],
      ),
    ),
  );
}
