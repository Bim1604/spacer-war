import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/components/bullet.dart';
import 'package:spacer_shooter/spacer/components/command.dart';
import 'package:spacer_shooter/spacer/components/audio_player_component.dart';
import 'package:spacer_shooter/spacer/components/enemy.dart';
import 'package:spacer_shooter/spacer/config/app_key.dart';
import 'package:spacer_shooter/spacer/models/playerData.dart';
import 'package:spacer_shooter/spacer/models/spaceship_details.dart';
import 'package:spacer_shooter/spacer/models/spaceship_list.dart';
import 'package:spacer_shooter/spacer/models/spaceship_types.dart';
import 'package:spacer_shooter/spacer/screens/game/spacer_game.dart';
import 'package:provider/provider.dart';
import 'package:spacer_shooter/spacer/utils/app_utils.dart';

class Player extends SpriteAnimationComponent with HasGameRef<SpacerGame>, KeyboardHandler, CollisionCallbacks{
  
  JoystickComponent joystick;
  Vector2 keyboardDelta = Vector2.zero();
  Random random = Random();
  int healthInit = 100;
  int health = 100;
  SpaceshipTypes spaceshipTypes;
  SpaceshipList listSpacerShip = SpaceshipList(listSpaceship: []);
  Spaceship spaceship;
  late PlayerData playerData;
  int tempScore = 0;
  int get score => tempScore;
  bool _shootMultipleBullets = false;
  late Timer _powerUpTimer;

  Vector2 getRandomVector() {
    return (Vector2.random(random) - Vector2(0.5, -1)) * 200;
  }

  Player({
    required this.joystick,
    required this.spaceshipTypes,
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
    Anchor? anchor,
    SpriteAnimation? spriteAnimation,
    Spaceship? spaceship,
  }) : spaceship = Spaceship.getSpaceShipByType(spaceshipTypes), super(
    size: size,
    animation: spriteAnimation,
    position: position,
    anchor: anchor
  ) {
    _powerUpTimer = Timer(4, onTick: (){
      _shootMultipleBullets = false;
    },);
  }

  @override
  void update(double dt) async {
    super.update(dt);
    _powerUpTimer.update(dt);
    if (joystick.direction != JoystickDirection.idle) {
      String sp = Spaceship.getAttributeById(AppKey.speed, spaceship).value.toString();
      double speed = double.parse(sp);
      position.add(joystick.relativeDelta  * speed * dt);
    }
    // giới hạn vị trí di chuyển
    position.clamp(Vector2(30,20), Vector2(game.fixedResolution.x - 20, game.fixedResolution.y - 30));

    final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 10,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: position.clone() + Vector2(- (size.x / 5), size.y / 3),
          child: CircleParticle(
            radius: 1,
            paint: Paint()..color = Colors.white
          )
        )
      )
    );
    if (animationTicker?.done() == true) {
      SpriteAnimation animationOriginal = await AppUtils().getSpriteAnimation(spaceship.imagePath, spaceship.jsonpath);
      animation = animationOriginal;
    }
    gameRef.add(particleComponent);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onMount() {
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
    if (gameRef.buildContext != null) {
      playerData = Provider.of<PlayerData>(gameRef.buildContext!, listen: false);
      listSpacerShip = Provider.of<SpaceshipList>(gameRef.buildContext!, listen: false);
      spaceship = listSpacerShip.listSpaceship.firstWhere((element) => element.id == spaceship.id);
      health = Spaceship.getAttributeById(AppKey.health, spaceship).value;
      healthInit = health;
    }
    super.onMount();
  }

  void joystickAction() async {
    SpriteAnimation animation = await AppUtils().getSpriteAnimation(AssetsSpacer.shootAnimation, AssetsSpacer.shootAnimationJson);
    SpriteAnimation bulletAnimation = await AppUtils().getSpriteAnimation(AssetsSpacer.bulletAnimation, AssetsSpacer.bulletAnimationJson);
    animation.loop = false;
    this.animation = animation;
    Bullet bullet = Bullet(
      speed: 550,
      position: game.player.position.clone(),
      size : Vector2(40, 40),
      animation: bulletAnimation,
      level: spaceship.level
    );
    // Anchor it to center and add to game world.
    bullet.anchor = Anchor.center;
    gameRef.add(bullet);
    gameRef.addCommand(Command<AudioPlayerComponent>(action: (audio) {
      audio.playSfx(AssetsSpacer.soundLaserSmall);
    }));
    if (_shootMultipleBullets) {
      for (var i = -1; i < 2; i += 2) {
        Bullet bullet = Bullet(
          speed: 450,
          position: game.player.position.clone(),
          size : Vector2(64, 64),
          animation: bulletAnimation,
          level: spaceship.level
        );
        // Anchor it to center and add to game world.
        bullet.anchor = Anchor.center;
        bullet.direction.rotate(i * pi / 6);
        gameRef.add(bullet);
      }
    }
  }

  void skillAction(String path) async {
    String animation = "";
    String animationJson = "";
    double? angle;
    double width = 40;
    if (spaceship.skill.id == 0) {
      animation = AssetsSpacer.laserGreenAnimation;
      animationJson = AssetsSpacer.laserGreenAnimationJson;
      angle = 0.0;
      width = game.fixedResolution.x;
    }
    SpriteAnimation bulletAnimation = await AppUtils().getSpriteAnimation(animation, animationJson);
    Bullet bullet = Bullet(
      speed: 1000,
      position: game.player.position.clone(),
      size : Vector2(width, 60),
      animation: bulletAnimation,
      level: spaceship.level,
      angleRote: angle,
      isLaser: true
    );
    // Anchor it to center and add to game world.
    bullet.anchor = Anchor.centerLeft;
    gameRef.add(bullet);
    gameRef.addCommand(Command<AudioPlayerComponent>(action: (audio) {
      audio.playSfx(AssetsSpacer.soundLaserSmall);
    }));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy) {
      health -= 10;
      if (health <= 0) {
        health = 0;
      } else {
        // gameRef.primaryCamera.(intensity: 10);
      }
    }
  }

  void addToScore(int points) {
    playerData.currentScore += points;
    tempScore = playerData.currentScore;
    playerData.money += points;
    playerData.save();
  }

  void increaseHealthBy(int points) {
    health += points;
    if (health > healthInit) {
      health = healthInit;
    }
  }

  void reset() {
    playerData.currentScore = 0;
    tempScore = 0;
    health = healthInit;
    position = Vector2(game.size.x / 2, game.size.y / 2 + game.size.y / 3);
  }

  void setSpaceshipType(SpaceshipTypes spaceshipTypes) async {
    this.spaceshipTypes = spaceshipTypes;
    spaceship = Spaceship.getSpaceShipByType(spaceshipTypes);
    animation = await AppUtils().getSpriteAnimation(spaceship.imagePath, spaceship.jsonpath);
  }

  void shootMultipleBullets() {
    _shootMultipleBullets = true;
    _powerUpTimer.stop();
    _powerUpTimer.start();
  }
}
