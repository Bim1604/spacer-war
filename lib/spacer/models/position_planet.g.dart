// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_planet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionPlanetAdapter extends TypeAdapter<PositionPlanet> {
  @override
  final int typeId = 8;

  @override
  PositionPlanet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionPlanet(
      x: fields[0] as double,
      y: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PositionPlanet obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.x)
      ..writeByte(1)
      ..write(obj.y);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionPlanetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
