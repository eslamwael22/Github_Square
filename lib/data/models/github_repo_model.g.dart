// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GithubRepoModelAdapter extends TypeAdapter<GithubRepoModel> {
  @override
  final int typeId = 0;

  @override
  GithubRepoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GithubRepoModel(
      name: fields[0] as String,
      description: fields[1] as String?,
      fork: fields[2] as bool,
      htmlUrl: fields[3] as String,
      owner: fields[4] as OwnerModel,
    );
  }

  @override
  void write(BinaryWriter writer, GithubRepoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.fork)
      ..writeByte(3)
      ..write(obj.htmlUrl)
      ..writeByte(4)
      ..write(obj.owner);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GithubRepoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
