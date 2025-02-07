// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spaceship_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpaceshipListAdapter extends TypeAdapter<SpaceshipList> {
  @override
  final int typeId = 5;

  @override
  SpaceshipList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpaceshipList(
      listSpaceship: (fields[0] as List).cast<Spaceship>(),
    );
  }

  @override
  void write(BinaryWriter writer, SpaceshipList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.listSpaceship);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpaceshipListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
