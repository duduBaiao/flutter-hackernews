import 'package:news/src/domain/data_sources/data_cache.dart';
import 'package:news/src/domain/data_sources/data_source.dart';

abstract class DbDataSource implements DataSource, DataCache {}
