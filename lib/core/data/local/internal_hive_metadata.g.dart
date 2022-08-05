// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internal_hive_metadata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InternalHiveMetadataAdapter extends TypeAdapter<InternalHiveMetadata> {
  @override
  final int typeId = 1;

  @override
  InternalHiveMetadata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InternalHiveMetadata(
      version: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InternalHiveMetadata obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.version)
      ..writeByte(1)
      ..write(obj.dateUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InternalHiveMetadataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
