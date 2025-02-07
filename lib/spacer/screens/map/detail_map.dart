import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/components/button/button_default.Component.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';
import 'package:spacer_shooter/spacer/screens/map/map_flame.Element.dart';
import 'package:spacer_shooter/spacer/screens/game_play.dart';

class DetailMap extends StatelessWidget {
  const DetailMap({super.key, required this.gameRef});
  static const String ID = "DetailMap.ID";
  final FlameSelectedMap gameRef;
  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
   return Center(
     child: Container(
      height: size.height * .7,
      width: size.width * .3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.2),
        border: GradientBoxBorder(
          gradient: LinearGradient(colors: [AppColor.ultramarineBlue, AppColor.deepSky]),
          width: 4,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Text(gameRef.mapNameSelected.name, style: TextStyle(
                      fontSize: 50,
                      color: AppColor.white,
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: AppColor.white,
                          offset: const Offset(0, 0)
                        )]
                    )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          int starGain = gameRef.mapNameSelected.star;
                          return Image.asset(AssetsSpacer.star, color: (index + 1) <= starGain ?  AppColor.yellow : AppColor.white, width: 60, height: 60);
                        },
                      ),
                    ),
                  ),
                  ButtonDefaultComponent(
                    callback: (){
                      gameRef.overlays.remove(ID);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const GamePlay())
                      );
                    },
                   title: "Go"
                  )
              ]
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                gameRef.overlays.remove(ID);
              },
              icon: Icon(Icons.close, size: 23, color: AppColor.white),
            )
          )
        ],
      ),
     ),
   );
  }
}