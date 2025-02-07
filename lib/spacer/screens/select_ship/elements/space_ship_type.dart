import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';

class SpaceShipTypeSelect extends StatelessWidget {
  const SpaceShipTypeSelect({super.key, required this.thumbnail, required this.name, required this.fireType, this.callback, this.isSelected = false, this.height = 70, this.isHideSpecial = false, this.width = 60});
  final String thumbnail;
  final String name;
  final String fireType;
  final Function()? callback;
  final bool isSelected;
  final double height;
  final double width;
  final bool isHideSpecial;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      height: height,
      child: ClipPath(
        clipper: SelectShipTypeClipCustom(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: AppColor.lightSkyBlue,
            onTap:() {
              if (callback != null) {
                callback!();
              }
            },
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isSelected ? [
                        AppColor.deepSky.withOpacity(0.9),
                        AppColor.ultramarineBlue.withOpacity(0.9),
                      ] : [
                        AppColor.lightSteelBlue.withOpacity(0.9),
                        AppColor.midnightBlue.withOpacity(0.9),
                        AppColor.midnightBlue.withOpacity(0.9),
                      ]
                    )
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width,
                        height: height,
                        child: Image.asset(thumbnail, fit: BoxFit.fill)
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: TextStyle(fontSize: 16, fontFamily: '', color: AppColor.white, fontWeight: FontWeight.w700)),
                          if (!isHideSpecial)
                            Text(fireType, style: TextStyle(fontSize: 16, fontFamily: '', color: AppColor.white, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SelectShipTypeClipCustom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width * .8, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}