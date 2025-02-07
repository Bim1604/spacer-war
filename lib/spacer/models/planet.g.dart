// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlanetComponentAdapter extends TypeAdapter<PlanetComponent> {
  @override
  final int typeId = 6;

  @override
  PlanetComponent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanetComponent(
      fields[0] as int,
      fields[1] as String,
      star: fields[2] as int,
      isLock: fields[3] as bool,
      positionPlanet: fields[7] as PositionPlanet,
      spriteString: fields[6] as String,
      score: fields[4] as int?,
      isFinish: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PlanetComponent obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.star)
      ..writeByte(3)
      ..write(obj.isLock)
      ..writeByte(4)
      ..write(obj.score)
      ..writeByte(5)
      ..write(obj.isFinish)
      ..writeByte(6)
      ..write(obj.spriteString)
      ..writeByte(7)
      ..write(obj.positionPlanet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanetComponentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
