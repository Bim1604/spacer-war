import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:gradient_borders/gradient_borders.dart';

class DiamondButtonComponent extends StatelessWidget {
  const DiamondButtonComponent({super.key, this.icon, this.imgIcon, this.callBack, this.width = 45, this.height = 45, this.color});
  final IconData? icon; 
  final String? imgIcon;
  final Function()? callBack;
  final double width;
  final double height;
  final Color? color;

  Widget getIconWidget() {
    Widget result = const SizedBox();
    if (icon != null) {
      result = Icon(icon);
    } else if (imgIcon != null) {
      result = Container(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(imgIcon!, width: width - 10, height: height - 10, color: color)
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationZ(
        math.pi / 4,
      ),
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey]),
            width: 2,
          ),
          gradient: RadialGradient(
            tileMode: TileMode.mirror,
            colors: [
              Color(0xFF62cff4),
              Color(0xFF2c67f2),
              Color(0xFF004ff9)
            ]
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF68BBE3),
              width: 2,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.blueAccent,
              onTap: () {
                if (callBack != null) {
                  callBack!();
                }
              },
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(
                  -(math.pi / 4),
                ),
                child: getIconWidget()
              ),
            ),
          ),
        ),
      ),
    );
  }
}