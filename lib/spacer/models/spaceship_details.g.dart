// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spaceship_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpaceshipAdapter extends TypeAdapter<Spaceship> {
  @override
  final int typeId = 4;

  @override
  Spaceship read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Spaceship(
      id: fields[0] as String,
      name: fields[1] as String,
      cost: fields[2] as int,
      jsonpath: fields[3] as String,
      imagePath: fields[4] as String,
      level: fields[6] as int,
      thumbnail: fields[5] as String,
      typeFire: fields[7] as String,
      listAttribute: (fields[8] as List).cast<Attribute>(),
      costPerLevel: fields[9] as int,
      currentCostUpgrade: fields[10] as int,
      currentLevel: fields[11] as int,
      skill: fields[12] as SkillModel,
    );
  }

  @override
  void write(BinaryWriter writer, Spaceship obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cost)
      ..writeByte(3)
      ..write(obj.jsonpath)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.thumbnail)
      ..writeByte(6)
      ..write(obj.level)
      ..writeByte(7)
      ..write(obj.typeFire)
      ..writeByte(8)
      ..write(obj.listAttribute)
      ..writeByte(9)
      ..write(obj.costPerLevel)
      ..writeByte(10)
      ..write(obj.currentCostUpgrade)
      ..writeByte(11)
      ..write(obj.currentLevel)
      ..writeByte(12)
      ..write(obj.skill);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpaceshipAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
