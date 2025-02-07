import 'package:hive/hive.dart';

part 'skill.g.dart';

@HiveType(typeId: 9)
class SkillModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String spriteString;
  @HiveField(3)
  int currentLevel;
  @HiveField(4)
  int costUpgrade;

  SkillModel({
    required this.id,
    required this.name,
    required this.spriteString,
    required this.currentLevel,
    required this.costUpgrade,
  });
}
