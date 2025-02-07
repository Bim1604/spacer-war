import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/config/app_key.dart';
import 'package:spacer_shooter/spacer/data/data.dart';
import 'package:spacer_shooter/spacer/models/attribute.dart';
import 'package:spacer_shooter/spacer/models/code_name.dart';
import 'package:spacer_shooter/spacer/models/spaceship_types.dart';
import 'package:spacer_shooter/spacer/models/skill.dart';
part 'spaceship_details.g.dart';

@HiveType(typeId: 4)
class Spaceship extends ChangeNotifier with HiveObjectMixin{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int cost;
  @HiveField(3)
  final String jsonpath;
  @HiveField(4)
  final String imagePath;
  @HiveField(5)
  final String thumbnail;
  @HiveField(6)
  final int level;
  @HiveField(7)
  final String typeFire;
  @HiveField(8)
  List<Attribute> listAttribute;
  @HiveField(9)
  int costPerLevel; // cost per level upgrade ship
  @HiveField(10)
  int currentCostUpgrade; // cost upgrade ship
  @HiveField(11)
  int currentLevel; // level current of ship
  @HiveField(12)
  SkillModel skill;

  Spaceship({
    required this.id,
    required this.name,
    required this.cost,
    this.jsonpath = "",
    this.imagePath = "",
    required this.level,
    this.thumbnail = "",
    this.typeFire = "",
    required this.listAttribute,
    required this.costPerLevel,
    required this.currentCostUpgrade,
    required this.currentLevel,
    required this.skill,
  });

  Spaceship.fromMap(Map<String, dynamic> map) : id = map['id'], name = map['name'], jsonpath = map['jsonpath'], imagePath = map['imagePath'], 
    thumbnail = map['thumbnail'], typeFire = map['typeFire'], costPerLevel = map['costPerLevel'] ?? 0, currentCostUpgrade = map['currentCostUpgrade'] ?? 0, currentLevel = map['currentLevel'] ?? 1,
    cost = map['cost'] ?? 0, level = map['level'] ?? 1, listAttribute = map['listAttribute'] ?? getListAttributeDefault(map['id']), skill = map['skill'] ?? SkillModel(id: 0, name: "", spriteString: "", currentLevel: 0, costUpgrade: 0);

  static List<Spaceship> fromJsonList(List? list) {
    if (list == null) return [];
    return list.map((item) => Spaceship.fromMap(item)).toList();
  }

  static Spaceship getSpaceShipByType(SpaceshipTypes spaceshipTypes) {
    return spaceship[spaceshipTypes] ?? spaceship.entries.first.value;
  }

  static SpaceshipTypes getTypeByShip(Spaceship ship) {
    SpaceshipTypes result = spaceship.keys.first;
    spaceship.forEach((key, value) { 
      if (value.id == ship.id) {
        result = key;
      }
    });
    return result;
  }

  static CodeName getAttributeById (String id, Spaceship spaceship) {
    CodeName result = CodeName(id: "", name: "", value: "");
    var finding = spaceship.listAttribute.firstWhereOrNull((element) => element.id == id);
    if (finding != null) {
      result = CodeName(id: finding.id, name: finding.name, value: finding.currentPoint);
    }
    return result;
  }

  static List<SpaceshipTypes> getAllSpaceship () {
    List<SpaceshipTypes> listShip = List.empty(growable: true);
    spaceship.forEach((key, value) {
     listShip.add(key);
    });
    return listShip;
  }

  static List<Spaceship> getAllSpaces() {
    List<Spaceship> listShip = List.empty(growable: true);
    spaceship.forEach((key, value) {
     listShip.add(value);
    });
    return listShip;
  }

  void saveListAttribute(List<Attribute> listAttribute, {String spaceShipId = ""}) async {
    this.listAttribute = listAttribute;
    final box = await Hive.openBox<Spaceship>(DataLocalLink.dataListShipBox);
    notifyListeners();
    await box.put(spaceShipId, this);
  }

  static List<Attribute> getListAttributeDefault(String id) {
    List<Attribute> listAttribute = List.empty(growable: true);
    switch (id) {
      // normal
      case AppKey.pilot:
        listAttribute.add(Attribute(id: AppKey.bulletLimit, name: "Bullet Limit", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 5, costUpgrade: 100, currentPoint: 5));
        listAttribute.add(Attribute(id: AppKey.attack, name: "Attack", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 5, costUpgrade: 100, currentPoint: 5));
        listAttribute.add(Attribute(id: AppKey.speed, name: "Speed", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 10, costUpgrade: 100, currentPoint: 200));
        listAttribute.add(Attribute(id: AppKey.health, name: "Health", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 50, costUpgrade: 100, currentPoint: 50));
        break;
      // balance
      case AppKey.knight:
        listAttribute.add(Attribute(id: AppKey.bulletLimit, name: "Bullet Limit", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 5, costUpgrade: 100, currentPoint: 5));
        listAttribute.add(Attribute(id: AppKey.attack, name: "Attack", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 8, costUpgrade: 100, currentPoint: 8));
        listAttribute.add(Attribute(id: AppKey.speed, name: "Speed", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 15, costUpgrade: 100, currentPoint: 250));
        listAttribute.add(Attribute(id: AppKey.health, name: "Health", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 60, costUpgrade: 100, currentPoint: 60));
        break;
      // attack
      case AppKey.ninja:
        listAttribute.add(Attribute(id: AppKey.bulletLimit, name: "Bullet Limit", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 6, costUpgrade: 100, currentPoint: 6));
        listAttribute.add(Attribute(id: AppKey.attack, name: "Attack", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 10, costUpgrade: 100, currentPoint: 10));
        listAttribute.add(Attribute(id: AppKey.speed, name: "Speed", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 20, costUpgrade: 100, currentPoint: 300));
        listAttribute.add(Attribute(id: AppKey.health, name: "Health", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 40, costUpgrade: 100, currentPoint: 40));
        break;
      // defend
      case AppKey.naruto:
        listAttribute.add(Attribute(id: AppKey.bulletLimit, name: "Bullet Limit", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 5, costUpgrade: 100, currentPoint: 5));
        listAttribute.add(Attribute(id: AppKey.attack, name: "Attack", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 5, costUpgrade: 100, currentPoint: 5));
        listAttribute.add(Attribute(id: AppKey.speed, name: "Speed", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 8, costUpgrade: 100, currentPoint: 200));
        listAttribute.add(Attribute(id: AppKey.health, name: "Health", level: 1, levelMax: 10, levelUpgrade: 1, pointPerLevel: 80, costUpgrade: 100, currentPoint: 80));
        break;
      default:
    }
    return listAttribute;
  }

  static int getCostPerLevel(int currentCostUpgrade, {int level = 1}) {
    int cost = currentCostUpgrade;
    if (level == 1) {
      cost = 0;
    }
    cost += currentCostUpgrade;
    return cost;
  }
  
  static Map<SpaceshipTypes,Spaceship> spaceship = {
    SpaceshipTypes.Pilot: Spaceship(
      id: AppKey.pilot,
      name: "Pilot",
      cost: 0,
      imagePath: "space_move.png",
      jsonpath: "space_move.json",
      level: 1,
      thumbnail: "assets/images/pilot_thumbnail.png",
      typeFire: "Laser Beam",
      currentLevel: 1,
      currentCostUpgrade: getCostPerLevel(500),
      costPerLevel: 50,
      listAttribute: getListAttributeDefault(AppKey.pilot),
      skill: SkillModel(id: 0, name: 'Laser Beam', spriteString: AssetsSpacer.laserGreen, currentLevel: 1, costUpgrade: 200)
    ),
    SpaceshipTypes.Knight: Spaceship(
      id: AppKey.knight,
      name: "Knight",
      cost: 100,
      imagePath: "knight_walk.png",
      jsonpath: "knight_walk.json",
      level: 2,
      thumbnail: "assets/images/knight_thumbnail.png",
      typeFire: "Fire Laze",
      currentLevel: 1,
      currentCostUpgrade: getCostPerLevel(700),
      costPerLevel: 700,
      listAttribute: getListAttributeDefault(AppKey.knight),
      skill: SkillModel(id: 1, name: 'Laser', spriteString: "", currentLevel: 1, costUpgrade: 250)
    ),
    SpaceshipTypes.CXC: Spaceship(
      id: AppKey.ninja,
      name: "Ninja",
      thumbnail: "assets/images/ninja_thumbnail.png",
      typeFire: "Punch",
      cost: 250,
      jsonpath: "ninja.png",
      imagePath: "ninja.json",
      level: 3,
      currentLevel: 1,
      currentCostUpgrade: getCostPerLevel(800),
      costPerLevel: 800,
      listAttribute: getListAttributeDefault(AppKey.ninja),
      skill: SkillModel(id: 2, name: 'Health', spriteString: "", currentLevel: 1, costUpgrade: 250)
    ),
    SpaceshipTypes.Raptor: Spaceship(
      id: AppKey.naruto,
      name: "Nabủto",
      typeFire: "Shuriken",
      thumbnail: "assets/images/nabuto_thumbnail.png",
      cost: 300,
      jsonpath: "naruto.json",
      imagePath: "naruto.png",
      level: 4,
      currentLevel: 1,
      currentCostUpgrade: getCostPerLevel(1000),
      costPerLevel: 1000,
      listAttribute: getListAttributeDefault(AppKey.naruto),
      skill: SkillModel(id: 3, name: 'Shuriken', spriteString: "", currentLevel: 1, costUpgrade: 300)
    ),
  };
}