// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spaceship_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpaceshipTypesAdapter extends TypeAdapter<SpaceshipTypes> {
  @override
  final int typeId = 1;

  @override
  SpaceshipTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SpaceshipTypes.Pilot;
      case 1:
        return SpaceshipTypes.Knight;
      case 2:
        return SpaceshipTypes.CXC;
      case 3:
        return SpaceshipTypes.Raptor;
      default:
        return SpaceshipTypes.Pilot;
    }
  }

  @override
  void write(BinaryWriter writer, SpaceshipTypes obj) {
    switch (obj) {
      case SpaceshipTypes.Pilot:
        writer.writeByte(0);
        break;
      case SpaceshipTypes.Knight:
        writer.writeByte(1);
        break;
      case SpaceshipTypes.CXC:
        writer.writeByte(2);
        break;
      case SpaceshipTypes.Raptor:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpaceshipTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
