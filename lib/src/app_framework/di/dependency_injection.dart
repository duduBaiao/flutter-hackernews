import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:http/http.dart' show Client;
import 'package:news/src/app_framework/providers/api_provider.dart';
import 'package:news/src/app_framework/providers/db_provider.dart';
import 'package:news/src/domain/providers/api_provider.dart';
import 'package:news/src/domain/providers/db_provider.dart';

void initDependencyInjection() {
  final injector = Injector.getInjector();

  final client = Client();

  injector.map<DbProvider>((i) => DbProviderImpl(), isSingleton: true);
  injector.map<ApiProvider>((i) => ApiProviderImpl(client), isSingleton: true);
}
