import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:http/http.dart' show Client;
import 'package:news/src/app_framework/data_sources/api_data_source.dart';
import 'package:news/src/app_framework/data_sources/db_data_source.dart';
import 'package:news/src/data/repositories/news_repository.dart';
import 'package:news/src/domain/data_sources/api_data_source.dart';
import 'package:news/src/domain/data_sources/db_data_source.dart';
import 'package:news/src/domain/repositories/news_repository.dart';
import 'package:news/src/use_cases/stories/clear_stories_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_item_use_case.dart';
import 'package:news/src/use_cases/stories/fetch_top_stories_ids_use_case.dart';

void initDependencyInjection() {
  final injector = Injector.getInjector();

  // Data Sources
  injector.map<DbDataSource>((i) => DbDataSourceImpl(), isSingleton: true);
  injector.map<ApiDataSource>((i) => ApiDataSourceImpl(Client()), isSingleton: true);

  // Repositories
  injector.map<NewsRepository>(
      (i) => NewsRepositoryImpl(
            i.get<DbDataSource>(),
            i.get<ApiDataSource>(),
          ),
      isSingleton: true);

  // Use Cases
  injector.map<FetchTopStoriesIdsUseCase>((i) => FetchTopStoriesIdsUseCase(i.get<NewsRepository>()));
  injector.map<FetchItemUseCase>((i) => FetchItemUseCase(i.get<NewsRepository>()));
  injector.map<ClearStoriesUseCase>((i) => ClearStoriesUseCase(i.get<NewsRepository>()));
}
