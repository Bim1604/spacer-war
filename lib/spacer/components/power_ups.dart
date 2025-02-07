import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/components/command.dart';
import 'package:spacer_shooter/spacer/components/audio_player_component.dart';
import 'package:spacer_shooter/spacer/components/enemy.dart';
import 'package:spacer_shooter/spacer/components/enemy_manager.dart';
import 'package:spacer_shooter/spacer/components/player.dart';
import 'package:spacer_shooter/spacer/components/power_up_manager.dart';
import 'package:spacer_shooter/spacer/screens/game/spacer_game.dart';

abstract class PowerUp extends SpriteComponent with HasGameRef<SpacerGame>, CollisionCallbacks {
  late Timer _timer;
  
  Sprite getSprite();
  void onActivated();

  PowerUp({
    Vector2? position,
    Vector2? size,
    Sprite? sprite,
  }) : super(
    position: position, size: size, sprite: sprite,
  ) {
    _timer = Timer(3, onTick: removeFromParent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }

  @override
  void onMount() {
    final shape = CircleHitbox.relative(
      0.5,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
    sprite = getSprite();
    _timer.start();
    super.onMount();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      gameRef.addCommand(Command<AudioPlayerComponent>(action: (audio) {
        audio.playSfx(AssetsSpacer.soundPowerUp);
      }));
      onActivated();
      removeFromParent();
    }
  }
}

class Nuke extends PowerUp {
   Nuke({Vector2? position, Vector2? size})
      : super( position: position, size: size);

  @override
  Sprite getSprite() {
    return PowerUpManager.nukeSprite;
  }

  @override
  void onActivated() {
    gameRef.addCommand(Command<Enemy>(action: (enemy) {
      enemy.destroy();
    }));
  }
}

class Health extends PowerUp {
   Health({Vector2? position, Vector2? size})
      : super( position: position, size: size);

  @override
  Sprite getSprite() {
    return PowerUpManager.healthSprite;
  }

  @override
  void onActivated() {
    gameRef.addCommand(Command<Player>(action: (player) {
      player.increaseHealthBy(10);
    }));
  }
}

class Freeze extends PowerUp {
   Freeze({Vector2? position, Vector2? size})
      : super( position: position, size: size);

  @override
  Sprite getSprite() {
    return PowerUpManager.freezeSprite;
  }

  @override
  void onActivated() {
    gameRef.addCommand(Command<Enemy>(action: (enemy) {
      enemy.freeze();
    }));
    gameRef.addCommand(Command<EnemyManager>(action: (enemyManager) {
      enemyManager.freeze();
    }));
    gameRef.addCommand(Command<PowerUpManager>(action: (powerUpManager) {
      powerUpManager.freeze();
    }));
  }
}

class MultiFire extends PowerUp {
   MultiFire({Vector2? position, Vector2? size})
      : super( position: position, size: size);

  @override
  Sprite getSprite() {
    return PowerUpManager.multiFireSprite;
  }

  @override
  void onActivated() {
    gameRef.addCommand(Command<Player>(action: (player) {
      player.shootMultipleBullets();
    }));
  }
}

