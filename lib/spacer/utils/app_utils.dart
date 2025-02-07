import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'dart:ui' as UI;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppUtils extends FlameGame {
  Future<SpriteAnimation> getSpriteAnimation(String imagePath, String jsonPath) async {
    final objectAnimation = await fromJSONAtlas(imagePath, jsonPath);
    SpriteAnimation animation = SpriteAnimation.spriteList(objectAnimation, stepTime: 0.1);
    return animation;
  }

  Future<UI.Image> loadImage(String imageName) async {
    final data = await rootBundle.load(imageName);
    return decodeImageFromList(data.buffer.asUint8List());
  }
}