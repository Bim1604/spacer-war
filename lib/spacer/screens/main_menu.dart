import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/components/button/button_default.Component.dart';
import 'package:spacer_shooter/spacer/components/button/diamon_button.Component.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';
import 'package:spacer_shooter/spacer/screens/select_ship/select_space_ship.dart';
import 'package:spacer_shooter/spacer/screens/setting_menu.dart';
import 'package:spacer_shooter/spacer/screens/shop/shop_main.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
     
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AssetsSpacer.background), fit: BoxFit.fill)
        ),
        height: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SPACER", style: TextStyle(
                        fontSize: 50,
                        color: AppColor.deepSky,
                        fontFamily: 'Title',
                        shadows: const [
                          Shadow(
                            blurRadius: 20.0,
                            color: Colors.white,
                            offset: Offset(0, 0)
                          )]
                      )),
                      Text(" SHOOTER", style: TextStyle(
                        fontSize: 50,
                        color: AppColor.steelBlue,
                        fontFamily: 'Title',
                        shadows: const [
                          Shadow(
                            blurRadius: 20.0,
                            color: Colors.white,
                            offset: Offset(0, 0)
                          )]
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            DiamondButtonComponent(imgIcon:AssetsSpacer.facebook, color: Colors.white, callBack:(){

                            }),
                            const SizedBox(height: 30.0,),
                            DiamondButtonComponent(imgIcon:AssetsSpacer.google, callBack:(){

                            }),
                            const SizedBox(height: 30.0,),
                            DiamondButtonComponent(imgIcon:AssetsSpacer.twitter, color: Colors.white, callBack:(){

                            }),
                          ],
                        )),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 25.0),
                            ButtonDefaultComponent(title: "Play",callback: () {
                              Future.delayed(const Duration(milliseconds: 200),(){
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => const SelectSpaceShip())
                                );
                              });
                            },),
                            const SizedBox(height: 20.0),
                            ButtonDefaultComponent(title: "MAP",callback: () {
                              
                            },),
                          ],
                      )),
                      Expanded(child:
                        Column(
                          children: [
                            DiamondButtonComponent(imgIcon:AssetsSpacer.gamePad, color: Colors.white, callBack:(){

                            }),
                            const SizedBox(height: 30.0,),
                            DiamondButtonComponent(icon:Icons.shopping_cart, callBack:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopMainScreen()));
                            }),
                            const SizedBox(height: 30.0,),
                            DiamondButtonComponent(icon:Icons.question_mark, callBack:(){

                            }),
                          ],
                        ) 
                      )
                    ],
                  ),
                ),
              ]
            ),
            Positioned(
              top: size.height / 10,
              right: size.width / 15,
              child: Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 10.0),
              child: DiamondButtonComponent(icon:Icons.settings, callBack:(){
                Future.delayed(const Duration(milliseconds: 200),(){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SettingsMenu())
                  );
                });
              })
            ),)
          ],
        )
      )
    );
  }
}