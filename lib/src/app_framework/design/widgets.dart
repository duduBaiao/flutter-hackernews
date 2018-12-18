import 'package:flutter/material.dart';
import 'package:news/src/app_framework/design/metrics.dart';

Widget padding(Widget child) => Padding(
      padding: EdgeInsets.all(Metrics.layout.padding),
      child: child,
    );

Widget lrPadding(Widget child) => Padding(
      padding: EdgeInsets.only(
        left: Metrics.layout.padding,
        right: Metrics.layout.padding,
      ),
      child: child,
    );

Widget lrbPadding(Widget child) => Padding(
      padding: EdgeInsets.only(
        left: Metrics.layout.padding,
        right: Metrics.layout.padding,
        bottom: Metrics.layout.padding,
      ),
      child: child,
    );

Widget progressIndicator() => Center(
      child: CircularProgressIndicator(),
    );

Widget loadingTile() => Container(
      height: Metrics.list.tile.defaultHeight,
      child: ListTile(
        title: Container(
          height: Metrics.list.tile.defaultTitleHeight,
          color: Colors.grey[100],
        ),
      ),
    );

Widget spacer() => _spacer(Metrics.spacing.regular);

Widget doubleSpacer() => _spacer(Metrics.spacing.regular * 2);

Widget _spacer(height) => SizedBox(height: height);
