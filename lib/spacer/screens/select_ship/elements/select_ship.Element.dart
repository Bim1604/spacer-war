import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spacer_shooter/spacer/components/button/button_default.Component.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';
import 'package:spacer_shooter/spacer/config/app_key.dart';
import 'package:spacer_shooter/spacer/models/code_name.dart';
import 'package:spacer_shooter/spacer/models/spaceship_details.dart';
import 'package:spacer_shooter/spacer/screens/map/select_map.dart';

class SelectShipElement extends StatefulWidget {
  const SelectShipElement({super.key, required this.spaceshipSelect});
  final Spaceship spaceshipSelect;

  @override
  State<SelectShipElement> createState() => _SelectShipElementState();
}

class _SelectShipElementState extends State<SelectShipElement> {
  late CodeName bulletLimit;
  late CodeName attack;
  late CodeName speed;
  late CodeName health;
  
  @override
  Widget build(BuildContext context) {
    bulletLimit = Spaceship.getAttributeById(AppKey.bulletLimit, widget.spaceshipSelect);
    attack = Spaceship.getAttributeById(AppKey.attack, widget.spaceshipSelect);
    speed = Spaceship.getAttributeById(AppKey.speed, widget.spaceshipSelect);
    health = Spaceship.getAttributeById(AppKey.health, widget.spaceshipSelect);
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: SelectShipClipCustom(),
      child: Container(
        alignment: Alignment.bottomRight,
        height: size.height * .8,
        width: size.width * .27,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.clamp,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.silverBlue,
              AppColor.darkMidnightBlue,
              AppColor.darkMidnightBlue,
              AppColor.darkMidnightBlue,
              AppColor.darkMidnightBlue,
              AppColor.darkMidnightBlue,
              AppColor.darkMidnightBlue,
              AppColor.darkMidnightBlue,
              AppColor.darkMidnightBlue,
              AppColor.silverBlue,
            ]
          )
        ),
        child: SizedBox(
          width: size.width / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.only(left: size.width * .3 / 5),
                child: Text(widget.spaceshipSelect.name.toUpperCase(), style: TextStyle(fontSize: 30, color: AppColor.carmineRed, fontFamily: '', fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * .3 / 5),
                child: Text(widget.spaceshipSelect.typeFire, style: const TextStyle(fontSize: 16, fontFamily: '', fontWeight: FontWeight.w600)),
              ),
              _buildAttributeShip(content: "${widget.spaceshipSelect.currentLevel}", percent: widget.spaceshipSelect.currentLevel / 5, title: "Level", size: size),
              _buildAttributeShip(content: attack.value.toString(), percent:attack.value / 500, title: attack.name, size: size),
              _buildAttributeShip(content: bulletLimit.value.toString(), percent:bulletLimit.value / 100, title: bulletLimit.name, size: size),
              _buildAttributeShip(content: speed.value.toString(), percent: speed.value / 1000, title: speed.name, size: size),
              _buildAttributeShip(content: health.value.toString(), percent: health.value / 5000, title: health.name, size: size),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(left: size.width * .3 / 5, bottom: 10.0),
                  child: ButtonDefaultComponent(
                    width: size.width / 7,
                    height: 40,
                    title: "Start",
                    callback: (){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const SelectMapScreen())
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttributeShip ({String title = "", Size? size, String content = "", double percent = 0.0}) {
    Widget result = Padding(
      padding: EdgeInsets.only(left: size!.width * .35 / 5, top: 5.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(title, style: const TextStyle(fontSize: 14, fontFamily: ''))
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            width: size.width / 12,
            height: 10,
            child: LinearProgressIndicator(
              minHeight: 10,
              backgroundColor: AppColor.white,
              value: percent,
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.greenYellow),
            ),
          ),
          Expanded(child: Text(content, style: const TextStyle(fontSize: 14, fontFamily: ''),)),
        ],
      ),
    );
    return result;
  }
}

class SelectShipClipCustom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * .3, 0);
    path.arcToPoint(Offset(size.width * .3 - 8, 10), radius: const Radius.circular(20), clockwise: false);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - size.width *.3, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}