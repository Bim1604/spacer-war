import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/models/playerData.dart';
import 'package:spacer_shooter/spacer/screens/game_over_menu.dart';
import 'package:spacer_shooter/spacer/widget/overlay/pauseMenu.dart';
import 'package:spacer_shooter/spacer/screens/game/spacer_game.dart';
import 'package:spacer_shooter/spacer/widget/overlay/pauseButton.dart';
import 'package:provider/provider.dart';


class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    PlayerData playerData = Provider.of<PlayerData>(context, listen: false);
    SpacerGame spacerGame = SpacerGame(playerData: playerData);
    return Scaffold(
      body: PopScope(
        onPopInvoked: (value) {
        },
        canPop: true,
        child: GameWidget(

          game: spacerGame,
          initialActiveOverlays: const [PauseButton.ID],
          overlayBuilderMap: {
            PauseButton.ID: (context, SpacerGame gameRef) => PauseButton(gameRef: gameRef),
            PauseMenu.ID: (context, SpacerGame gameRef) => PauseMenu(gameRef: gameRef),
            GameOverMenu.ID: (context, SpacerGame gameRef) => GameOverMenu(gameRef: gameRef),
          },
        )
      ),
    );
  }
}