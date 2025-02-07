import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/components/button/button_default.Component.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';
import 'package:spacer_shooter/spacer/config/app_key.dart';
import 'package:spacer_shooter/spacer/models/code_name.dart';
import 'package:spacer_shooter/spacer/models/spaceship_details.dart';

class InformationPlayer extends StatefulWidget {
  const InformationPlayer({super.key, required this.spaceshipSelect, this.isOwn = false, this.callback, this.canBuy = false});
  final Spaceship spaceshipSelect;
  final bool isOwn;
  final bool canBuy;
  final Function()? callback;

  @override
  State<InformationPlayer> createState() => _InformationPlayerState();
}

class _InformationPlayerState extends State<InformationPlayer> {
  late CodeName bulletLimit;
  late CodeName attack;
  late CodeName speed;
  late CodeName health;

  @override
  void initState() {
    super.initState();
  }

  Color getColorTopLine() {
    Color color = AppColor.platinumBlue;
    if (widget.spaceshipSelect.currentLevel == 2) {
      color = AppColor.burntOrange;
    } else if (widget.spaceshipSelect.currentLevel == 3) {
      color = AppColor.bloodRed;
    } else if (widget.spaceshipSelect.currentLevel == 4) {
      color = AppColor.paleVioletRed;
    } else if (widget.spaceshipSelect.currentLevel == 5) {
      color = AppColor.cadetBlue;
    }
    return color;
  }

  Color getColorBorder() {
    Color color = AppColor.deepSky;
    if (widget.spaceshipSelect.currentLevel == 2) {
      color = AppColor.brightOrange;
    } else if (widget.spaceshipSelect.currentLevel == 3) {
      color = AppColor.neonRed;
    } else if (widget.spaceshipSelect.currentLevel == 4) {
      color = AppColor.hotPink;
    } else if (widget.spaceshipSelect.currentLevel == 5) {
      color = AppColor.darkTurquoise;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    bulletLimit = Spaceship.getAttributeById(AppKey.bulletLimit, widget.spaceshipSelect);
    attack = Spaceship.getAttributeById(AppKey.attack, widget.spaceshipSelect);
    speed = Spaceship.getAttributeById(AppKey.speed, widget.spaceshipSelect);
    health = Spaceship.getAttributeById(AppKey.health, widget.spaceshipSelect);
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      width: size.width * .25,
      height: size.height * .55,
      decoration: BoxDecoration(
        color: getColorBorder(),
        borderRadius: BorderRadius.circular(5.0)
      ),
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.steelBlue,
        ),
        child: Column(
          children: [
            Container(
              width: size.width * .25 / 3,
              height: 3,
              color: getColorTopLine(),
            ),
            Text(widget.spaceshipSelect.name, style: TextStyle(fontSize: 25, color: AppColor.white, fontWeight: FontWeight.w700, fontFamily: "Title")),
            Expanded(
              child: Container(
                width: size.width,
                height: size.height,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
                  gradient: RadialGradient(
                    focalRadius: 0.1,
                    radius: 0.7,
                    colors: [
                      AppColor.white,
                      AppColor.darkBlue,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (!widget.isOwn)
                              _buildAttributeShip(title: "Cost", content: "${widget.spaceshipSelect.cost} coin", isUnderline: true, canBuy: widget.canBuy),
                            _buildAttributeShip(title: "Species", content: widget.spaceshipSelect.typeFire),
                            _buildAttributeShip(title: bulletLimit.name, content: bulletLimit.value.toString()),
                            _buildAttributeShip(title: attack.name, content: attack.value.toString()),
                            _buildAttributeShip(title: speed.name, content: speed.value.toString()),
                            _buildAttributeShip(title: health.name, content: health.value.toString()),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap:(){
                          if (widget.callback != null) {
                            widget.callback!();
                          }
                        },
                        child: Stack(
                          children: [
                            ButtonDefaultComponent(
                              callback: () {
                                if (widget.callback != null) {
                                  widget.callback!();
                                }
                              },
                              title: widget.isOwn ? "Upgrade" : "Buy", height: 30, width: 100,
                              textStyle: TextStyle(fontSize: 12, color: AppColor.white, fontFamily: "", fontWeight: FontWeight.w700),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: widget.canBuy ? [
                                  AppColor.springGreen,
                                  AppColor.lime,
                                  AppColor.springGreen,
                                  AppColor.lime,
                                  AppColor.springGreen,
                                ] : [
                                  AppColor.neonRed,
                                  AppColor.neonRed,
                                ],
                              ),
                            ),
                            Visibility(
                              visible: widget.isOwn,
                              child: Positioned(
                                top: 2,
                                left: 10,
                                child: Image.asset(AssetsSpacer.upgrades, width: 18, height: 18)
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
       ),
     );
  }
}

  Widget _buildAttributeShip ({String title = "", String content = "", bool isUnderline = false, bool canBuy = false}) {
    Widget result = Row(
      children: [
        Container(
          color: Colors.transparent,
          child: Text(title, style: TextStyle(color: isUnderline ? (canBuy ? AppColor.limeGreen : AppColor.neonRed) : AppColor.white, fontSize: 13, fontFamily: '', fontWeight: FontWeight.w700), textAlign: TextAlign.left,),
        ),
        Expanded(child: Text(content, style: TextStyle(color: isUnderline ? (canBuy ? AppColor.limeGreen : AppColor.neonRed) : AppColor.white, fontSize: 13, fontFamily: '', fontWeight: FontWeight.w700), textAlign: TextAlign.right)),
      ],
    );
    return result;
  }