import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CountdownButton extends ButtonComponent {
  final double countdownHours;
  late _ArcComponent arcComponent;
  late double elapsedTime;

  CountdownButton({
    required this.countdownHours,
    required VoidCallback onPressed,
    Vector2? position,
  }) : super(
    position: position ?? Vector2.zero(),
    size: Vector2.all(100),
    anchor: Anchor.center,
    onPressed: onPressed,
  ) {
    elapsedTime = 0;

    // N?n xám
    final background = CircleComponent(
      radius: size.x / 2,
      paint: Paint()..color = Colors.grey[800]!,
    );

    // Arc countdown theo gi?
    arcComponent = _ArcComponent(
      radius: size.x / 2,
      color: Colors.blue,
    );

    // Thêm vào `button`
    button?.addAll([background, arcComponent]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    elapsedTime += dt / 3600;

    double progress = (elapsedTime / countdownHours).clamp(0, 1);
    arcComponent.updateProgress(progress);

    if (elapsedTime >= countdownHours) {
      arcComponent.updateProgress(1.0);
      removeFromParent();
    }
  }
}

// Component v? vòng cung countdown
class _ArcComponent extends PositionComponent {
  final double radius; // Bán kính vòng tròn
  double progress; // Ti?n trình t? 0 -> 1
  final Paint arcPaint; // Paint cho vòng cung

  _ArcComponent({
    required this.radius,
    this.progress = 0.0,
    Color color = Colors.blue,
  }) : arcPaint = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Góc b?t ??u (12 gi? -90 ??)
    double startAngle = -pi / 2;
    // Góc quét theo ti?n trình
    double sweepAngle = progress * 2 * pi;

    Rect rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);

    canvas.drawArc(rect, startAngle, sweepAngle, false, arcPaint);
  }

  // C?p nh?t ti?n trình countdown
  void updateProgress(double newProgress) {
    progress = newProgress.clamp(0.0, 1.0);
  }
}