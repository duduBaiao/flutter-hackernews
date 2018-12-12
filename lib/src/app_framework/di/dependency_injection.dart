import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:http/http.dart' show Client;
import 'package:news/src/app_framework/data_sources/api_data_source.dart';
import 'package:news/src/app_framework/data_sources/db_data_source.dart';
import 'package:news/src/data/repositories/news_repository.dart';
import 'package:news/src/domain/data_sources/api_data_source.dart';
import 'package:news/src/domain/data_sources/db_data_source.dart';
import 'package:news/src/domain/repositories/news_repository.dart';

void initDependencyInjection() {
  final injector = Injector.getInjector();

  final client = Client();

  injector.map<DbDataSource>((i) => DbDataSourceImpl(), isSingleton: true);
  injector.map<ApiDataSource>((i) => ApiDataSourceImpl(client), isSingleton: true);

  injector.map<NewsRepository>(
      (i) => NewsRepositoryImpl(i.get<DbDataSource>(), i.get<ApiDataSource>()),
      isSingleton: true);
}
