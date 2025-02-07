import 'package:hive/hive.dart';

part 'position_planet.g.dart';

@HiveType(typeId: 8)
class PositionPlanet {
  @HiveField(0)
  double x;
  @HiveField(1)
  double y;

  PositionPlanet({
    required this.x,
    required this.y,
  });
}
