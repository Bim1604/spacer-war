
import 'package:hive/hive.dart';

part 'spaceship_types.g.dart';

@HiveType(typeId: 1)
enum SpaceshipTypes {
  @HiveField(0)
  Pilot,
  @HiveField(1)
  Knight,
  @HiveField(2)
  CXC,
  @HiveField(3)
  Raptor,
}
