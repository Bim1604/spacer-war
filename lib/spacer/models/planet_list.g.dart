// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planet_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlanetListAdapter extends TypeAdapter<PlanetList> {
  @override
  final int typeId = 7;

  @override
  PlanetList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanetList(
      listPlanet: (fields[0] as List).cast<PlanetComponent>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlanetList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.listPlanet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanetListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
