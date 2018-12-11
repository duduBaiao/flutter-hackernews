import 'package:news/src/domain/providers/cache_provider.dart';
import 'package:news/src/domain/providers/source_provider.dart';

abstract class DbProvider implements SourceProvider, CacheProvider {}
