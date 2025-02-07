import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/components/bullet.dart';
import 'package:spacer_shooter/spacer/components/command.dart';
import 'package:spacer_shooter/spacer/components/audio_player_component.dart';
import 'package:spacer_shooter/spacer/models/enemy_data.dart';
import 'package:spacer_shooter/spacer/components/player.dart';
import 'package:spacer_shooter/spacer/screens/game/spacer_game.dart';
class Enemy extends SpriteComponent with HasGameRef<SpacerGame>, CollisionCallbacks {
  double _speed = 250;
  Random random = Random();
  late Timer _freezeTimer;
  final EnemyData enemyData;
  Vector2 moveDirection = Vector2(-1,0);
  int _hitPoint = 10;
  int _initHealth = 10;
  final TextComponent _hpText = TextComponent(text: '10 HP', 
    textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white,
        ),
      ));

  Vector2 getRandomVector() {
    return (Vector2.random(random) - Vector2.random(random)) * 500;
  }

  Vector2 getRandomDirectionVector() {
    return (Vector2.random(random) - Vector2(1, 1).normalized());
  }

  Enemy({
    required Sprite? sprite,
    required Vector2? position,
    required Vector2? size,
    required this.enemyData, 
  }) : super(
    sprite: sprite, position:  position, size: size
  ) {
    angle = pi;
    _speed = enemyData.speed;
    _hitPoint = enemyData.level * 10;
    _initHealth = _hitPoint;
    _hpText.text = '$_hitPoint HP';
    _freezeTimer = Timer(2, onTick: (){
      _speed = enemyData.speed;
    });

    if (enemyData.hMove) {
      moveDirection = getRandomDirectionVector();
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(0 / 2, size.y,  (_hitPoint / _initHealth) * 100 / 1.5, 17), 
      Paint()..color = Colors.blue.withOpacity(0.7),
    );
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _hpText.text = '$_hitPoint HP';
    if (_hitPoint <= 0) {
      destroy();
    }
    _freezeTimer.update(dt);
    position += moveDirection * _speed * dt;

    if (position.x < 0 || position.y < 0 || position.y > game.fixedResolution.y) {
      removeFromParent();
    } 
    else if ((position.y < size.y / 2) || (position.y > (game.fixedResolution.y))) {
      moveDirection.y *= -1;
    }
  }

  @override
  void onMount() {
    super.onMount();
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
    _hpText.angle = pi;
    _hpText.position = Vector2(50, 80);
    add(_hpText);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bullet) {
      _hitPoint -= other.level * 10;
    } else if ( other is Player) {
      _hitPoint = 0;
    }
  }

  void destroy() {
      removeFromParent();
      gameRef.addCommand(Command<AudioPlayerComponent>(action: (audio) {
        audio.playSfx(AssetsSpacer.soundLaser);
      }));
      final command = Command<Player>(action: (player) {
        player.addToScore(enemyData.killPoint);
      });
      game.addCommand(command);

      // game.player.score += 1;
      final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 20,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: position.clone() + Vector2((size.x / 2), size.y / 3),
          child: CircleParticle(
            radius: 1,
            paint: Paint()..color = Colors.white
          )
        )
      )
    );
    gameRef.add(particleComponent);
  } 

  @override
  void onRemove() {
    super.onRemove();
  }

  void freeze() {
    _speed = 0;
    _freezeTimer.stop();
    _freezeTimer.start();
  }
}