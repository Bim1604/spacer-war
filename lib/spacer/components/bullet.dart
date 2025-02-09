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
  int laserHealth;
  Timer? timer;
  int durationSkill;

  Bullet({
    required this.speed,
    required SpriteAnimation? animation,
    required Vector2? position,
    required Vector2? size,
    required this.level,
    this.angleRote,
    this.laserHealth = 3,
    this.isLaser = false,
    this.durationSkill = 3
  }) : super(
    animation: animation, position:  position, size: size, angle: angleRote ?? pi / 2
  ) {
    if (isLaser) {
      timer = Timer(durationSkill.toDouble(), onTick: (){
        removeFromParent();
      });
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isLaser) {
        position += direction * speed * dt;
    } else {
      timer?.update(dt);
    }
    if (position.y < 0) {
      removeFromParent();
    }
  }

  @override
  void onRemove() {
    timer?.stop();
    super.onRemove();
  }

  @override
  void onMount() {
    super.onMount();
    if (isLaser) {
      final shape = RectangleHitbox.relative(Vector2(1,.8), parentSize: size);
      add(shape);
      timer?.start();
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
    if (other is Enemy) {
      if (isLaser) {
        // timer = Timer(3, autoStart: false, onTick: (){
        //   removeFromParent();
        // });
        // laserHealth--;
        // if (laserHealth == 0) {
        //   removeFromParent();
        // }
        return;
      }
      removeFromParent();
    }
  }
}