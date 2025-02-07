import 'dart:math';
import 'package:flame/components.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/components/power_ups.dart';
import 'package:spacer_shooter/spacer/screens/game/spacer_game.dart';

enum PowerUpTypes {
  Health,
  Freeze,
  Nuke,
  MultiFire
}

class PowerUpManager extends Component with HasGameRef<SpacerGame>{
  late Timer _spawnTimer;
  late Timer _freezeTimer;
  static late Sprite healthSprite;
  static late Sprite nukeSprite;
  static late Sprite freezeSprite;
  static late Sprite multiFireSprite;

  Random random = Random();

  static final Map<PowerUpTypes, PowerUp Function(Vector2 position, Vector2 size)> 
    _powerUpMap = {
      PowerUpTypes.Health: (position, size) => Health(position: position, size: size),
      PowerUpTypes.Freeze: (position, size) => Freeze(position: position, size: size),
      PowerUpTypes.Nuke: (position, size) => Nuke(position: position, size: size),
      PowerUpTypes.MultiFire: (position, size) => MultiFire(position: position, size: size),
    };

  PowerUpManager() : super() {
    _spawnTimer = Timer(4, onTick: _spawnPowerUp, repeat: true);
    _freezeTimer = Timer(2, onTick: (){
      _spawnTimer.start();
    });
  }

  void _spawnPowerUp() async {
    Vector2 initialSize = Vector2(64, 64);
    Vector2 position = Vector2(random.nextDouble() * game.fixedResolution.x, random.nextDouble() * game.fixedResolution.y);
    position.clamp(Vector2.zero(), Vector2(game.size.x * 6, game.size.y * 12));
    int randomIndex = random.nextInt(PowerUpTypes.values.length);
    final fn = _powerUpMap[PowerUpTypes.values.elementAt(randomIndex)];
    var powerUp = fn?.call(position, initialSize);
    powerUp?.anchor = Anchor.center;
    if (powerUp != null) {
      gameRef.add(powerUp);
    }
  }

  @override
  void onMount() {
    super.onMount();
    healthSprite = Sprite(gameRef.images.fromCache(AssetsSpacer.health));
    nukeSprite = Sprite(gameRef.images.fromCache(AssetsSpacer.nuke));
    freezeSprite = Sprite(gameRef.images.fromCache(AssetsSpacer.freeze));
    multiFireSprite = Sprite(gameRef.images.fromCache(AssetsSpacer.multipleShoot));
    _spawnTimer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    _spawnTimer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _spawnTimer.update(dt);
    _freezeTimer.update(dt);
  }

  
  void reset () {
    _spawnTimer.stop;
    _spawnTimer.start();
  }

  void freeze() {
    _spawnTimer.stop();
    _freezeTimer.stop();
    _freezeTimer.start();
  }
}