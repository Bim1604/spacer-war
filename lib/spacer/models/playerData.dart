import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/models/spaceship_details.dart';
import 'package:hive/hive.dart';
import 'package:spacer_shooter/spacer/models/spaceship_types.dart';

part 'playerData.g.dart';

@HiveType(typeId: 0)
class PlayerData extends ChangeNotifier with HiveObjectMixin {
  @HiveField(0)
  SpaceshipTypes spaceshipType;
  @HiveField(1)
  final List<SpaceshipTypes> ownedSpaceships;
  @HiveField(2)
  final int hightScore;
  @HiveField(3)
  int money;
  @HiveField(4)
  int currentMap; // map reach
  @HiveField(5)
  int diamond; // map reach
  int currentScore = 0;

  PlayerData({
    required this.spaceshipType,
    required this.ownedSpaceships,
    required this.hightScore,
    required this.money,
    required this.currentMap,
    required this.diamond,
  });

  PlayerData.fromMap(Map<String, dynamic> map) : spaceshipType = map['currentSpaceshipType'], ownedSpaceships = map['ownedSpaceshipTypes']
    .map((e) => e as SpaceshipTypes).cast<SpaceshipTypes>().toList(),
    hightScore = map['hightScore'] ?? 0, currentMap = map['currentMap'] ?? 2, diamond = map['diamond'] ?? 0, money = map['money'] ?? 0;

  static Map<String, dynamic> defaultData = {
    'currentSpaceshipType' : SpaceshipTypes.Pilot,
    'ownedSpaceshipTypes': [SpaceshipTypes.Pilot],
    'highScore': 0,
    'money' : 0,
    'currentMap': 1,
    'diamond': 0,
  };

  static PlayerData getPlayerDataDefault () {
    return PlayerData(currentMap: 1, diamond: 0, hightScore: 0, money: 0, ownedSpaceships: [SpaceshipTypes.Pilot], spaceshipType: SpaceshipTypes.Pilot);
  }

  PlayerData getData() {
    return PlayerData(spaceshipType: spaceshipType, ownedSpaceships: ownedSpaceships, hightScore: hightScore, money: money, currentMap: currentMap, diamond: diamond);
  }

  bool isOwned(SpaceshipTypes spaceshipTypes) {
    return ownedSpaceships.contains(spaceshipTypes);
  }

  bool canBuy(SpaceshipTypes spaceshipTypes) {
    return (money >= Spaceship.getSpaceShipByType(spaceshipTypes).cost);
  }

  bool isEquipped(SpaceshipTypes spaceshipTypes) {
    return (spaceshipType == spaceshipTypes);
  }

  void buy(SpaceshipTypes spaceshipTypes) {
    if (canBuy(spaceshipTypes) && (!isOwned(spaceshipTypes))) {
      money -= Spaceship.getSpaceShipByType(spaceshipTypes).cost;
      ownedSpaceships.add(spaceshipTypes);
      notifyListeners();
      save();
    }
  }

  void equip(SpaceshipTypes spaceshipTypes) async {
    spaceshipType = spaceshipTypes;
    notifyListeners();
    await save();
  }

  void saveMoney(int money) async {
    this.money = money;
    notifyListeners();
    await save();
  }

  void saveCurrentMap(int map) async {
    currentMap = map;
    notifyListeners();
    await save();
  }
}
