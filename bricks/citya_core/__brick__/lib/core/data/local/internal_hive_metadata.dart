import 'package:hive_flutter/hive_flutter.dart';

part 'internal_hive_metadata.g.dart';

@HiveType(typeId: 1)
class InternalHiveMetadata {
  @HiveField(0)
  final String version;

  @HiveField(1)
  final DateTime dateUpdated;

  InternalHiveMetadata({required this.version}) : dateUpdated = DateTime.now();
}
