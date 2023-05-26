// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adminModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminModelAdapter extends TypeAdapter<AdminModel> {
  @override
  final int typeId = 2;

  @override
  AdminModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminModel(
      username: fields[1] as String,
      password: fields[2] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AdminModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
