// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeModelAdapter extends TypeAdapter<RecipeModel> {
  @override
  final int typeId = 3;

  @override
  RecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeModel(
      name: fields[1] as String,
      category: fields[7] as String,
      type: fields[3] as String,
      image: fields[8] as String,
      servings: fields[4] as String,
      ingrediants: fields[5] as String,
      directions: fields[6] as String,
      description: fields[2] as String,
      duration: fields[9] as String,
      isVisible: fields[10] as bool,
      totalFav: fields[11] as int,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.servings)
      ..writeByte(5)
      ..write(obj.ingrediants)
      ..writeByte(6)
      ..write(obj.directions)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.duration)
      ..writeByte(10)
      ..write(obj.isVisible)
      ..writeByte(11)
      ..write(obj.totalFav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
