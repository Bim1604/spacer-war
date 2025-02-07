import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/screens/map/map_flame.Element.dart';
import 'package:spacer_shooter/spacer/screens/map/detail_map.dart';

FlameSelectedMap flameSelectedMap = FlameSelectedMap();
class SelectMapScreen extends StatelessWidget {
  const SelectMapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: GameWidget(
            game: flameSelectedMap,
            overlayBuilderMap: {
              DetailMap.ID: (context, FlameSelectedMap gameRef) => DetailMap(gameRef: gameRef),
            },
          ),
        ),
      ),
    );
  }
}