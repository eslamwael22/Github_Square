// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OwnerModelAdapter extends TypeAdapter<OwnerModel> {
  @override
  final int typeId = 1;

  @override
  OwnerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OwnerModel(
      login: fields[0] as String,
      htmlUrl: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OwnerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.login)
      ..writeByte(1)
      ..write(obj.htmlUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
