import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/settings.dart';
import 'package:spacer_shooter/spacer/screens/game/spacer_game.dart';
import 'package:provider/provider.dart';

class AudioPlayerComponent extends Component with HasGameRef<SpacerGame>{
  @override
  FutureOr<void> onLoad() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      AssetsSpacer.soundLaser,
      AssetsSpacer.soundLaserSmall,
      AssetsSpacer.soundPowerUp
    ]);
    return super.onLoad();
  }

  void playBgm(String fileName) {
    if (gameRef.buildContext != null) {
      if (Provider.of<Setting>(gameRef.buildContext!, listen: false).backGroundMusic) {
        FlameAudio.bgm.play(fileName);
      } 
    }
  }

  void playSfx(String fileName) {
     if (gameRef.buildContext != null) {
      if (Provider.of<Setting>(gameRef.buildContext!, listen: false).soundEffects) {
        FlameAudio.play(fileName);
      } 
    }
  }

  void stopBgm() {
    FlameAudio.bgm.stop();
  }

}