import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/components/button/diamon_button.Component.dart';
import 'package:spacer_shooter/spacer/widget/overlay/pauseMenu.dart';
import 'package:spacer_shooter/spacer/screens/game/spacer_game.dart';

class PauseButton extends StatelessWidget {
  static const String ID = "PauseButton.ID";
  final SpacerGame gameRef;
  const PauseButton({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(top: 20, right: size.width * .2),
      alignment: Alignment.topRight,
      child: DiamondButtonComponent(
        icon: Icons.pause_rounded, 
        callBack: () {
          gameRef.pauseEngine();
          gameRef.overlays.add(PauseMenu.ID);
          gameRef.overlays.remove(PauseButton.ID);
        },
      ),
    );
  }
}