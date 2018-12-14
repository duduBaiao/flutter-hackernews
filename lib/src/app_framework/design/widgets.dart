import 'package:flutter/material.dart';
import 'package:news/src/app_framework/design/metrics.dart';

Widget centeredMessage(String message) {
  return Center(
    child: Text(message),
  );
}

Widget simpleItem(String title) {
  return Container(
    height: Metrics.list.item.defaultHeight,
    child: centeredMessage(title),
  );
}
