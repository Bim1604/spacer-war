// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerDataAdapter extends TypeAdapter<PlayerData> {
  @override
  final int typeId = 0;

  @override
  PlayerData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerData(
      spaceshipType: fields[0] as SpaceshipTypes,
      ownedSpaceships: (fields[1] as List).cast<SpaceshipTypes>(),
      hightScore: fields[2] as int,
      money: fields[3] as int,
      currentMap: fields[4] as int,
      diamond: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PlayerData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.spaceshipType)
      ..writeByte(1)
      ..write(obj.ownedSpaceships)
      ..writeByte(2)
      ..write(obj.hightScore)
      ..writeByte(3)
      ..write(obj.money)
      ..writeByte(4)
      ..write(obj.currentMap)
      ..writeByte(5)
      ..write(obj.diamond);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
