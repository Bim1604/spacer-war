import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:spacer_shooter/spacer/config/app_key.dart';

part 'attribute.g.dart';

@HiveType(typeId: 3)
class Attribute {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int level; // level attribute
  @HiveField(3)
  int pointPerLevel;
  @HiveField(4)
  int levelMax;
  @HiveField(5)
  int levelUpgrade; // level ship
  @HiveField(6)
  int costUpgrade;
  @HiveField(7)
  int currentPoint;

  Attribute({
    required this.id,
    required this.name,
    required this.level,
    required this.pointPerLevel,
    required this.levelMax,
    required this.levelUpgrade,
    required this.costUpgrade,
    required this.currentPoint,
  });

  Attribute copyWith({
    String? id,
    String? name,
    int? level,
    int? pointPerLevel,
    int? levelMax,
    int? levelUpgrade,
    int? costUpgrade,
    int? currentPoint,
  }) {
    return Attribute(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      pointPerLevel: pointPerLevel ?? this.pointPerLevel,
      levelMax: levelMax ?? this.levelMax,
      levelUpgrade: levelUpgrade ?? this.levelUpgrade,
      costUpgrade: costUpgrade ?? this.costUpgrade,
      currentPoint: currentPoint ?? this.currentPoint,
    );
  }

  int getCostUpgrade(int costUpgrade, int levelShip, String shipID) {
    int cost = costUpgrade;
    if (levelShip == 1) {
      switch (shipID) {
        case AppKey.pilot:
          cost = cost + 10;
          break;
        case AppKey.knight:
          cost = cost + 20;
          break;
        case AppKey.ninja:
          cost = cost + 30;
          break;
        case AppKey.naruto:
          cost = cost + 40;
          break;
        default:
      }
    } else if (levelShip == 2) {
      switch (shipID) {
        case AppKey.pilot:
          cost = cost + 20;
          break;
        case AppKey.knight:
          cost = cost + 30;
          break;
        case AppKey.ninja:
          cost = cost + 40;
          break;
        case AppKey.naruto:
          cost = cost + 50;
          break;
        default:
      }
    } else if (levelShip == 3) {
      switch (shipID) {
        case AppKey.pilot:
          cost = cost + 30;
          break;
        case AppKey.knight:
          cost = cost + 40;
          break;
        case AppKey.ninja:
          cost = cost + 50;
          break;
        case AppKey.naruto:
          cost = cost + 60;
          break;
        default:
      }
    } else if (levelShip == 4) {
      switch (shipID) {
        case AppKey.pilot:
          cost = cost + 40;
          break;
        case AppKey.knight:
          cost = cost + 50;
          break;
        case AppKey.ninja:
          cost = cost + 60;
          break;
        case AppKey.naruto:
          cost = cost + 70;
          break;
        default:
      }
    } else if (levelShip == 5) {
      switch (shipID) {
        case AppKey.pilot:
          cost = cost + 50;
          break;
        case AppKey.knight:
          cost = cost + 60;
          break;
        case AppKey.ninja:
          cost = cost + 70;
          break;
        case AppKey.naruto:
          cost = cost + 80;
          break;
        default:
      }
    }
    return cost;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'level': level,
      'pointPerLevel': pointPerLevel,
      'levelMax': levelMax,
      'levelUpgrade': levelUpgrade,
      'costUpgrade': costUpgrade,
      'currentPoint': currentPoint,
    };
  }

  factory Attribute.fromMap(Map<String, dynamic> map) {
    return Attribute(
      id: map['id'] as String,
      name: map['name'] as String,
      level: map['level'] as int,
      pointPerLevel: map['pointPerLevel'] as int,
      levelMax: map['levelMax'] as int,
      levelUpgrade: map['levelUpgrade'] as int,
      costUpgrade: map['costUpgrade'] as int,
      currentPoint: map['currentPoint'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attribute.fromJson(String source) => Attribute.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Attribute(id: $id, name: $name, level: $level, pointPerLevel: $pointPerLevel, levelMax: $levelMax, levelUpgrade: $levelUpgrade, costUpgrade: $costUpgrade, currentPoint: $currentPoint)';
  }

  @override
  bool operator ==(covariant Attribute other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.level == level &&
      other.pointPerLevel == pointPerLevel &&
      other.levelMax == levelMax &&
      other.levelUpgrade == levelUpgrade &&
      other.costUpgrade == costUpgrade &&
      other.currentPoint == currentPoint;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      level.hashCode ^
      pointPerLevel.hashCode ^
      levelMax.hashCode ^
      levelUpgrade.hashCode ^
      costUpgrade.hashCode ^
      currentPoint.hashCode;
  }
}
