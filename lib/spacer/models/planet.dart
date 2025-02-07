import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';
import 'package:spacer_shooter/spacer/models/playerData.dart';
import 'package:spacer_shooter/spacer/screens/map/map_flame.Element.dart';
import 'package:spacer_shooter/spacer/models/position_planet.dart';

part 'planet.g.dart';

@HiveType(typeId: 6)
class PlanetComponent extends SpriteButtonComponent with HasGameRef<FlameSelectedMap> {
  PlanetComponent(this.id, this.name, { 
    this.star = 0, 
    this.isLock = false,
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
    required this.positionPlanet,
    required this.spriteString,
    Function()? callback,
    this.score,
    this.isFinish = false,
  }) : super(
    button: sprite,
    size: size, 
    position: position,
    onPressed: callback,
  );
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int star;
  @HiveField(3)
  bool isLock;
  @HiveField(4)
  int? score;
  ui.Image? imageLock;
  late PlayerData playerData;
  @HiveField(5)
  bool isFinish;
  @HiveField(6)
  String spriteString;
  @HiveField(7)
  PositionPlanet positionPlanet;

  @override
  void render(Canvas canvas) async {
    super.render(canvas);
    
    canvas.drawCircle(
      const Offset(830.4 * 0.092, 384.0 * 0.15), 55, 
      Paint()..color = AppColor.deepSky.withAlpha(100)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
    );
    if (imageLock != null && isLock) {
      canvas.scale(1/20);
      canvas.drawImage(imageLock!,  const Offset(1000, -550.0), paint);
    }
  }


  @override
  void onLoad() async {
    imageLock = await loadImage(AssetsSpacer.lock);
  }

  Future<ui.Image> loadImage(String imageName) async {
    final data = await rootBundle.load(imageName);
    return decodeImageFromList(data.buffer.asUint8List());
  }
  
  // Future<List<PlanetComponent>> getPlanetDataListDefault() async {
  //   List<PlanetComponent> listPlanet = List.empty(growable: true);
  //   listPlanet.add(PlanetComponent(1, "MAP 1", star: 2, isLock: false, spriteString: , sprite: await Sprite.load(AssetsSpacer.planet1), position: Vector2(830.4 * 0.1, 384.0 * 0.6), size: Vector2(150,150)));
  //   listPlanet.add(PlanetComponent(2, "MAP 2", star: 1, isLock: false, sprite: await Sprite.load(AssetsSpacer.planet2), position: Vector2(830.4 * 0.3, 384.0 * 0.45), size: Vector2(150,150)));
  //   listPlanet.add(PlanetComponent(3, "MAP 3", star: 0, isLock: true, sprite: await Sprite.load(AssetsSpacer.planet3), position: Vector2(830.4 * 0.5, 384.0 * 0.55), size: Vector2(150,150)));
  //   listPlanet.add(PlanetComponent(4, "MAP 4", star: 0, isLock: true, sprite: await Sprite.load(AssetsSpacer.planet4), position: Vector2(830.4 * 0.7, 384.0 * 0.6), size: Vector2(150,150)));
  //   listPlanet.add(PlanetComponent(5, "MAP 5", star: 0, isLock: true, sprite: await Sprite.load(AssetsSpacer.planet5), position: Vector2(830.4 * 0.8, 384.0 * 0.3), size: Vector2(150,150)));
  //   listPlanet.add(PlanetComponent(6, "MAP 6", star: 0, isLock: true, sprite: await Sprite.load(AssetsSpacer.planet6), position: Vector2(830.4 * 0.6, 384.0 * 0.1), size: Vector2(150,150)));
  //   return listPlanet;
  // }

  void saveScore(int score) {

  }

  void saveStar(int star) {

  }

  bool isLockMap(int mapId, List<PlanetComponent> listPlanet) {
    bool result = false;
    if (mapId > 1 && listPlanet[mapId - 1].isFinish) {
      result = true;
    }
    return result;
  }
}