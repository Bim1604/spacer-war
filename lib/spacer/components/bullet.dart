import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:spacer_shooter/spacer/components/enemy.dart';

class Bullet extends SpriteAnimationComponent with CollisionCallbacks {
  double speed;
  Vector2 direction = Vector2(1, 0);
  final int level;
  final double? angleRote;
  final bool isLaser;

  Bullet({
    required this.speed,
    required SpriteAnimation? animation,
    required Vector2? position,
    required Vector2? size,
    required this.level,
    this.angleRote,
    this.isLaser = false
  }) : super(
    animation: animation, position:  position, size: size, angle: angleRote ?? pi / 2
  );

  @override
  void update(double dt) {
    super.update(dt);
    position += direction * speed * dt;
    if (position.y < 0) {
      removeFromParent();
    }
  }

  @override
  void onMount() {
    super.onMount();
    if (isLaser) {
      final shape = RectangleHitbox.relative(Vector2(1,1), parentSize: size);
      add(shape);
    } else {
      final shape = CircleHitbox.relative(
        0.4,
        parentSize: size,
        position: size / 2,
        anchor: Anchor.center,
      );
      add(shape);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // If the other Collidable is Enemy, remove this bullet.
    if (other is Enemy) {
      removeFromParent();
    }
  }
}