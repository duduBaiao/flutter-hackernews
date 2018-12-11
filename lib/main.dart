import 'package:flutter/material.dart';
import 'package:news/src/app_framework/app.dart';
import 'package:news/src/app_framework/di/dependency_injection.dart';

void main() {
  initDependencyInjection();
  runApp(App());
}
