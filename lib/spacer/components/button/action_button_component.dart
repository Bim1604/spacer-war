import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CountdownButton extends ButtonComponent {
  final double countdownSeconds;
  late _ArcComponent arcComponent;
  late double elapsedTime;
  final PositionComponent positionComponent;
  final Anchor anchorP;
  final Vector2 sizeP;
  bool enable = true;
  final Function()? onEventAction;

  CountdownButton({
    required this.countdownSeconds,
    required this.onEventAction,
    required this.positionComponent,
    Vector2? position,
    required this.sizeP,
    this.anchorP = Anchor.center
  }) : super(
    position: position ?? Vector2.zero(),
    size: sizeP,
    anchor: anchorP,
    button: positionComponent,
  ) {
    elapsedTime = 0;
    arcComponent = _ArcComponent(
      radius: size.x / 2,
      color: Colors.blue,
    );
    PositionComponent comp = PositionComponent(
      children: [
        positionComponent,
        arcComponent
      ]
    );
    button = comp;
  }

  void onPressedCallback() {
    if (enable == false || onEventAction == null) return;
    onEventAction!();
    enable = false;
  }

  @override
  void Function()? get onPressed => onPressedCallback;

  @override
  void update(double dt) {
    super.update(dt);
    if (!enable) {
      elapsedTime += dt;

      double progress = (elapsedTime / countdownSeconds).clamp(0, 1);
      arcComponent.updateProgress(progress);

      if (elapsedTime >= countdownSeconds) {
        arcComponent.updateProgress(1.0);
        elapsedTime = 0;
        enable = true;
      }
    }
  }
}

class _ArcComponent extends PositionComponent {
  final double radius;
  double progress = 1.0;
  final Paint arcPaint;

  _ArcComponent({
    required this.radius,
    Color color = Colors.blue,
  }) : arcPaint = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    double startAngle = -pi / 2;
    double sweepAngle = progress * 2 * pi;

    Rect rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);

    canvas.drawArc(rect, startAngle, sweepAngle, false, arcPaint);
  }

  void updateProgress(double newProgress) {
    progress = newProgress.clamp(0.0, 1.0);
  }
}