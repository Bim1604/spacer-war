import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:spacer_shooter/spacer/components/enemy.dart';

class SkillComponent extends SpriteComponent with CollisionCallbacks {
  double _speed = 450;
  Vector2 direction = Vector2(1, 0);
  final int level;

  SkillComponent({
    required Sprite? sprite,
    required Vector2? position,
    required Vector2? size,
    required this.level,
  }) : super(
    sprite: sprite, position:  position, size: size, angle: pi / 2
  );

  @override
  void update(double dt) {
    super.update(dt);
    position += direction * _speed * dt;

    if (position.y < 0) {
      removeFromParent();
    }
  }

  @override
  void onMount() {
    super.onMount();

    // Adding a circular hitbox with radius as 0.4 times
    //  the smallest dimension of this components size.
    final shape = CircleHitbox.relative(
      0.4,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
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