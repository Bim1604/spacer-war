// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttributeAdapter extends TypeAdapter<Attribute> {
  @override
  final int typeId = 3;

  @override
  Attribute read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attribute(
      id: fields[0] as String,
      name: fields[1] as String,
      level: fields[2] as int,
      pointPerLevel: fields[3] as int,
      levelMax: fields[4] as int,
      levelUpgrade: fields[5] as int,
      costUpgrade: fields[6] as int,
      currentPoint: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Attribute obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.level)
      ..writeByte(3)
      ..write(obj.pointPerLevel)
      ..writeByte(4)
      ..write(obj.levelMax)
      ..writeByte(5)
      ..write(obj.levelUpgrade)
      ..writeByte(6)
      ..write(obj.costUpgrade)
      ..writeByte(7)
      ..write(obj.currentPoint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttributeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
