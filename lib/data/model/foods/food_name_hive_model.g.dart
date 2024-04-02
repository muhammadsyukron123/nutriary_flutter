// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_name_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodNameHiveModelAdapter extends TypeAdapter<FoodNameHiveModel> {
  @override
  final int typeId = 2;

  @override
  FoodNameHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodNameHiveModel(
      foodId: fields[0] as String?,
      foodName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FoodNameHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.foodId)
      ..writeByte(1)
      ..write(obj.foodName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodNameHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
