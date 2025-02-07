import 'dart:math';
import 'package:flame/components.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/components/enemy.dart';
import 'package:spacer_shooter/spacer/models/enemy_data.dart';
import 'package:spacer_shooter/spacer/models/playerData.dart';
import 'package:spacer_shooter/spacer/screens/game/spacer_game.dart';
import 'package:provider/provider.dart';

class EnemyManager extends Component with HasGameRef<SpacerGame>{
  late Timer timer;
  late Timer _freezeTimer;

  Random random = Random();

  EnemyManager() : super() {
    timer = Timer(1, onTick: _spawnEnemy, repeat: true);
    _freezeTimer = Timer(2, onTick: (){
      timer.start();
    });
  }



  void _spawnEnemy() async {
    Vector2 initialSize = Vector2(64, 64);
    Vector2 position = Vector2(game.fixedResolution.x, random.nextDouble() * game.fixedResolution.y);
    position.clamp(Vector2.zero(), Vector2(game.fixedResolution.x * 6, game.fixedResolution.y * 12));
    // position.clamp(Vector2.zero(), Vector2(game.size.x * 6, game.size.y * 12));
    if (gameRef.buildContext != null) {
      int currentScore = Provider.of<PlayerData>(gameRef.buildContext!, listen: false).currentScore;
      int maxLevel = mapScoreToMaxEnemyLevel(currentScore);
      final enemyData = _enemyDataList.elementAt(random.nextInt(maxLevel));

      Enemy enemy = Enemy(
        position: position, 
        size : initialSize,
        sprite: await gameRef.loadSprite(enemyData.sprite),
        enemyData: enemyData
      );

      gameRef.add(enemy);

    }

  }

  int mapScoreToMaxEnemyLevel(int score) {
    int level = 1;
    if (score > 60) {
      level = 4;
    } else if (score > 20) {
      level = 3;
    } else if (score > 40) {
      level = 2;
    }
    return level;
  }

  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
    _freezeTimer.update(dt);
  }

  
  void reset () {
    timer.stop;
    timer.start();
  }

  void freeze() {
    timer.stop();
    _freezeTimer.stop();
    _freezeTimer.start();
  }

  static const List<EnemyData> _enemyDataList = [
    EnemyData(
      killPoint: 1,
      speed: 200,
      sprite: AssetsSpacer.enemy_01,
      level: 1,
      hMove: false,
    ),
    EnemyData(
      killPoint: 2,
      speed: 200,
      sprite: AssetsSpacer.enemy_02,
      level: 1,
      hMove: true,
    ),
    EnemyData(
      killPoint: 4,
      speed: 200,
      sprite: AssetsSpacer.enemy_03,
      level: 3,
      hMove: false,
    ),
    EnemyData(
      killPoint: 4,
      speed: 200,
      sprite: AssetsSpacer.enemy_04,
      level: 5,
      hMove: true,
    ),
    EnemyData(
      killPoint: 6,
      speed: 250,
      sprite: AssetsSpacer.enemy_05,
      level: 3,
      hMove: false,
    ),
    EnemyData(
      killPoint: 6,
      speed: 250,
      sprite: AssetsSpacer.enemy_06,
      level: 5,
      hMove: true,
    ),
    EnemyData(
      killPoint: 6,
      speed: 250,
      sprite: AssetsSpacer.enemy_06,
      level: 6,
      hMove: false,
    ),
  ];
}