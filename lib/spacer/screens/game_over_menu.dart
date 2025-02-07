import 'package:flutter/widgets.dart';
import 'package:spacer_shooter/spacer/screens/main_menu.dart';
import 'package:spacer_shooter/spacer/screens/game/spacer_game.dart';
import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/widget/overlay/pauseButton.dart';

class GameOverMenu extends StatelessWidget {
  const GameOverMenu({super.key, required this.gameRef});
  static const String ID = "GameOverMenu.ID";
  final SpacerGame gameRef;

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
   return Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const Padding(
             padding:  EdgeInsets.symmetric(vertical: 35.0),
             child: Text("Game Over", style: TextStyle(
               fontSize: 50,
               color: Colors.black,
               shadows: [
                 Shadow(
                   blurRadius: 20.0,
                   color: Colors.white,
                   offset: Offset(0, 0)
                 )]
             )),
           ),
           SizedBox(
             width: size.width / 3,
             child: ElevatedButton(
               onPressed: (){
                 gameRef.overlays.remove(GameOverMenu.ID);
                 gameRef.overlays.add(PauseButton.ID);
                 gameRef.reset();
                 gameRef.resumeEngine();
               }, child: const Text('Restart', style: TextStyle(fontFamily: 'Game', fontSize: 24))
             ),
           ),
           SizedBox(
             width: size.width / 3,
             child: ElevatedButton(
               onPressed: (){
                 gameRef.overlays.remove(GameOverMenu.ID);
                 gameRef.reset();
                 gameRef.resumeEngine();
                 Navigator.of(context).pushReplacement(
                   MaterialPageRoute(builder: (context) => const MainMenu())
                 );
               }, child: const Text('Exit', style: TextStyle(fontFamily: 'Game', fontSize: 24))
             ),
           ),
         ]
     ),
   );
  }
}