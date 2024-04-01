// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_today_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SummaryHiveModelAdapter extends TypeAdapter<SummaryHiveModel> {
  @override
  final int typeId = 1;

  @override
  SummaryHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SummaryHiveModel(
      userId: fields[0] as int?,
      logDate: fields[1] as DateTime,
      bmr: fields[2] as double,
      consumedCalories: fields[3] as double,
      remainingCalories: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SummaryHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.logDate)
      ..writeByte(2)
      ..write(obj.bmr)
      ..writeByte(3)
      ..write(obj.consumedCalories)
      ..writeByte(4)
      ..write(obj.remainingCalories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SummaryHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
