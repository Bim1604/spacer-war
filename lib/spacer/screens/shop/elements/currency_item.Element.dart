import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';

class CurrencyItem extends StatelessWidget {
  const CurrencyItem({super.key, required this.icon, required this.button, required this.content, this.callback});

  final String icon;
  final String content;
  final String button;
  final Function()? callback;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 30,
      child: Stack(
        children: [
          Positioned(
            left: 25,
            top: 4,
            bottom: 4,
            child: Container(
              width: 100,
              padding: const EdgeInsets.only(right: 25, top: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    AppColor.deepSky,
                    AppColor.ultramarineBlue
                  ],
                ),
              ),
              child: Text(content, style: TextStyle(fontSize: 15, color: AppColor.white, fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
            ),
          ),
          Positioned(
            left: 3,
            top: 0,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage( fit: BoxFit.cover, image: AssetImage(icon))
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap:(){},
                splashColor: AppColor.springGreen,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    shape: BoxShape.rectangle,
                    image: DecorationImage( fit: BoxFit.cover, image: AssetImage(button))
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}