import 'dart:async';
import 'dart:ui' as UI;
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';
import 'package:spacer_shooter/spacer/screens/game/spacer_game.dart';
import 'package:spacer_shooter/spacer/utils/app_utils.dart';

class ButtonSkillComponent extends CustomPainterComponent with HasGameRef<SpacerGame> {
  ButtonSkillComponent( 
     { 
    required this.imgPath,
    Vector2? position,
    Vector2? size,
  }) : super(
    size: size, 
    position: position,
  );

  String imgPath;

  @override
  FutureOr<void> onLoad() async {
    painter = Skill1CustomPaint(imgPath: imgPath);
    return super.onLoad();
  }
  
}

class Skill1CustomPaint extends CustomPainter {

  final String imgPath;
  Skill1CustomPaint({
    required this.imgPath,
  });
  
  @override
  void paint(Canvas canvas, Size size) async {
    UI.Image img = await AppUtils().loadImage(imgPath);
    canvas.drawImage(img, const Offset(60, 60), Paint()..color = AppColor.black..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

