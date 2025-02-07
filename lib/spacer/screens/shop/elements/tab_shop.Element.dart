import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';

class TaBShopElement extends StatelessWidget {
  const TaBShopElement({super.key, this.callBack, required this.iconString, this.width = 25, this.height = 25, this.isSelect = false});

  final Function()? callBack;
  final String iconString;
  final double width;
  final double height;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ClipPath(
      clipper: ClipTypeShop(),
      child: Container(
        width: 50,
        padding: const EdgeInsets.fromLTRB(3, 2, 0, 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
          colors: isSelect ? [
            AppColor.cadmiumOrange,
            AppColor.brightOrange
          ] : [
            AppColor.dodgerBlue,
            AppColor.dodgerBlue,
            AppColor.darkMidnightBlue,
          ],
        )),
        child: ClipPath(
          clipper: ClipTypeShop(),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
              tileMode: TileMode.mirror,
              colors: isSelect ? [
                AppColor.deepSky.withOpacity(0.9),
                AppColor.ultramarineBlue.withOpacity(0.9),
              ] : [
                AppColor.ultramarineBlue,
                AppColor.midnightBlue
              ],
            )),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){
                  if (callBack != null) {
                    callBack!();
                  }
                },
                splashColor: AppColor.deepSky,
                child: Container(
                  padding: const EdgeInsets.only(left: 4.0),
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height,
                  child: Image.asset(iconString, color: AppColor.white, width: width, height: height)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ClipTypeShop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double widthClip = size.width * .4;
    double heightClip =  size.height * .2;
    path.moveTo(widthClip, 0);
    path.arcToPoint(Offset(0, heightClip), radius: const Radius.circular(50), clockwise: false);
    path.lineTo(0, size.height - heightClip);
    path.arcToPoint(Offset(widthClip, size.height), radius: const Radius.circular(50), clockwise: false);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(widthClip, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}