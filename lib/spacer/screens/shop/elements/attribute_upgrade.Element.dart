import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';
import 'package:spacer_shooter/spacer/models/attribute.dart';

class AttributeUpgradeElement extends StatelessWidget {
  const AttributeUpgradeElement({super.key, this.height = 130, required this.attribute, this.callback});

  final double height;
  final Attribute attribute;
  final Function(Attribute)? callback;

  @override
  Widget build(BuildContext context) {

    List<Color> getGradientColorBGTitle() {
      List<Color> color = [  AppColor.silverBlue,AppColor.midnightBlue];
      if (attribute.levelUpgrade == 2) {
        color = [
          AppColor.brightOrange,
          AppColor.cadmiumOrange,
        ];
      } else if (attribute.levelUpgrade == 3) {
        color = [
          AppColor.rubyRed,
          AppColor.brightRed,
        ];
      } else if (attribute.levelUpgrade == 4) {
        color = [
          AppColor.lightPink,
          AppColor.deepPink,
        ];
      } else if (attribute.levelUpgrade == 5) {
        color = [
          AppColor.aquamarine,
          AppColor.aqua,
        ];
      }
      return color;
    }

    List<Color> getGradientColorBGBodyBorder() {
      List<Color> color = [ AppColor.gunmetalGray.withBlue(200), AppColor.midnightBlue.withBlue(200),];
      if (attribute.levelUpgrade == 2) {
        color = [
          AppColor.persimmon,
          AppColor.coral,
        ];
      } else if (attribute.levelUpgrade == 3) {
        color = [
          AppColor.bloodRed,
          AppColor.crimson,
        ];
      } else if (attribute.levelUpgrade == 4) {
        color = [
          AppColor.mediumVioletRed,
          AppColor.pink,
        ];
      } else if (attribute.levelUpgrade == 5) {
        color = [
          AppColor.darkTurquoise,
          AppColor.lightCyan,
        ];
      }
      return color;
    }

    Size size = MediaQuery.sizeOf(context);
    return ClipPath(
      clipper: AttributeClip(), 
      child: SizedBox(
        width: size.width * .2,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: height / 16.25,
              child: ClipPath(
                clipper: TitleLimitClip(),
                child: Container(
                  alignment: Alignment.center,
                  width: size.width * .24,
                  height: 35, 
                  decoration: BoxDecoration(
                    color: AppColor.silverBlue.withOpacity(0.6),
                  ),
                ),
              )
            ),
            Positioned(
              top: height / 14.5,
              child: ClipPath(
                clipper: TitleLimitClip(),
                child: Container(
                  alignment: Alignment.center,
                  width: size.width * .24,
                  height: 35, 
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: getGradientColorBGTitle(),
                    ),
                  ),
                  child: Text(attribute.name.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w700, color: AppColor.white, fontSize: 11, fontFamily: ''), textAlign: TextAlign.center),
                ),
              )
            ),
            Positioned(
              top: height / 4.2, 
              left: size.width * .2 / 6, 
              child: Container(
                width: 10, height: 1,  
                decoration: BoxDecoration(
                  color: AppColor.deepSky,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.white,
                      spreadRadius: 0.5
                    )
                  ]
                ),
              )
            ),
            Positioned(
              top: height / 4.2, 
              right: size.width * .2 / 6, 
              child: Container(
                width: 10, height: 1,  
                decoration: BoxDecoration(
                  color: AppColor.deepSky,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.white,
                      spreadRadius: 0.5
                    )
                  ]
                ),
              )
            ),
            // Body
            ClipPath(
              clipper: BodyClipBackground(),
              child: Container(
                width: size.width * .2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: getGradientColorBGBodyBorder(),
                  ),
                ),
              )
            ),
            ClipPath(
              clipper: BodyClip(),
              child: Container(
                width: size.width * .2,
                decoration: BoxDecoration(
                  color: AppColor.black.withBlue(80)
                ),
              )
            ),
            ClipPath(
              clipper: BodyClipInSide(),
              child: Container(
                width: size.width * .2,
                decoration: BoxDecoration(
                  color: AppColor.black.withBlue(30)
                ),
              )
            ),
            // QUANTITY
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              width: (2 + (attribute.levelMax -1) * 2 + 5 + 6) + attribute.levelMax * 5,
              height: 25,
              decoration: BoxDecoration(
                color: AppColor.silver,
              ),
              child: ClipPath(
                clipper: QuantityBorderClip(),
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  width: (2 + (attribute.levelMax -1) * 2 + 5 + 6) + attribute.levelMax * 5,
                  height: 25,
                  decoration: BoxDecoration(
                    color: AppColor.iris,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              padding: const EdgeInsets.all(2.0),
              width: (2 + (attribute.levelMax -1) * 2 + 5 + 6) + attribute.levelMax * 5,
              height: 25,
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                  color: AppColor.darkBlue,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: Row(
                  children: [
                    for (int i = 0; i < attribute.level; i++) 
                      Container(
                        height: size.height,
                        width: 5,
                        decoration: BoxDecoration(
                          color: AppColor.dodgerBlue,
                          borderRadius: BorderRadius.circular(1.0)
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 2.0),
                      ),
                  ],
                ),
              ),
            ),
            // button buy
            Positioned(
              top: 82,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: size.width * .2  / 2 + 15,
                    height: 30,
                    child: ClipPath(
                      clipper: ButtonUpLY1Clip(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.springGreen
                        ),
                        width: size.width,
                        height: 30,
                        child: ClipPath(
                          clipper: ButtonUpLY2Clip(),
                          child: Container(
                            color: AppColor.black,
                            width: size.width,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(1.5),
                    width: size.width * .2  / 2 + 15,
                    height: 30,
                    child: ClipPath(
                      clipper: ButtonUpLY3Clip(),
                      child: Container(
                        decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColor.forestGreen.withOpacity(0.5),
                            AppColor.forestGreen.withOpacity(0.7),
                            AppColor.forestGreen,
                            AppColor.forestGreen.withOpacity(0.7),
                            AppColor.forestGreen.withOpacity(0.5),
                          ],
                        ),
                      ),
                        width: size.width,
                        height: 30,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * .2  / 2 + 15,
                    height: 30,
                    padding: const EdgeInsets.all(5),
                    child: ClipPath(
                      clipper: ButtonUpLY4Clip(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.springGreen
                        ),
                        width: size.width,
                        height: 30,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (){
                        if (callback != null) {
                          callback!(attribute);
                        }
                      },
                      splashColor: AppColor.springGreen,
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width * .2  / 2 + 15,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3.0, left: 3.0),
                              child: Image.asset(AssetsSpacer.coin, width: 20, height: 20),
                            ),
                            const SizedBox(width: 3.0),
                            Text(attribute.costUpgrade.toString(), style: TextStyle(fontSize: 16, color: AppColor.white, fontWeight: FontWeight.w700),),
                          ],
                        )
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class AttributeClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double widthClipTop = size.width * .2;
    double heightClipTop = 4.5;
    double widthClipBot = size.width * .15;
    path.lineTo(widthClipTop, 0);
    path.lineTo(widthClipTop + 3, heightClipTop);
    path.lineTo(size.width - (widthClipTop + 3), heightClipTop);
    path.lineTo(size.width - (widthClipTop), 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * .8);
    path.lineTo(size.width - widthClipBot , size.height);
    path.lineTo(widthClipBot, size.height);
    path.lineTo(0, size.height * .8);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class TitleLimitClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double widthClipTop = size.width * .25;
    double heightClipTop = 5;
    double curve = size.width * .2;
    path.moveTo(10, 0);
    path.lineTo(widthClipTop, 0);
    path.lineTo(widthClipTop + 3,  heightClipTop);
    path.lineTo(size.width - (widthClipTop + 3), heightClipTop);
    path.lineTo(size.width - widthClipTop, 0);
    path.lineTo(size.width - curve, 0);
    path.arcToPoint(Offset(size.width - (curve - 2), size.height), radius: const Radius.circular(50));
    path.lineTo((curve - 2), size.height);
    path.arcToPoint(Offset((curve), 0), radius: const Radius.circular(50));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class BodyClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double paddingY = size.height * .35;
    double paddingX = size.width / 27;
    double paddingYB = size.height / 17;
    double widthClipTop = size.width * .1;
    double heightClipTop = 6;
    double widthClipBot = size.width * .15;
    path.moveTo(paddingX, paddingY);
    path.lineTo(widthClipTop, paddingY);
    path.lineTo(widthClipTop + 3, paddingY - heightClipTop);
    path.lineTo(size.width - widthClipTop - 3, paddingY - heightClipTop);
    path.lineTo(size.width - widthClipTop, paddingY);
    path.lineTo(size.width - paddingX, paddingY);
    path.lineTo(size.width - paddingX, size.height * .8);
    path.lineTo(size.width -  widthClipBot, size.height - paddingYB);
    path.lineTo(widthClipBot, size.height - paddingYB);
    path.lineTo(paddingX, size.height * .8);
    path.lineTo(paddingX, paddingY);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class BodyClipInSide extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double paddingY = size.height * .35;
    double paddingX = size.width / 10;
    double paddingYB = size.height / 8;
    double widthClipTop = size.width * .1;
    double heightClipTop = 6;
    double widthClipBot = size.width * .15;
    path.moveTo(paddingX, paddingY);
    path.lineTo(widthClipTop, paddingY);
    path.lineTo(widthClipTop + 3, paddingY - heightClipTop);
    path.lineTo(size.width - widthClipTop - 3, paddingY - heightClipTop);
    path.lineTo(size.width - widthClipTop, paddingY);
    path.lineTo(size.width - paddingX, paddingY);
    path.lineTo(size.width - paddingX, size.height * .8);
    path.lineTo(size.width -  widthClipBot, size.height - paddingYB);
    path.lineTo(widthClipBot, size.height - paddingYB);
    path.lineTo(paddingX, size.height * .8);
    path.lineTo(paddingX, paddingY);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class BodyClipBackground extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double paddingY = size.height * .3 + 3;
    path.moveTo(0, paddingY);
    path.lineTo(size.width, paddingY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, paddingY);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class QuantityBorderClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double widthClip = 7;
    path.moveTo(0, widthClip);
    path.lineTo(widthClip, 0);
    path.lineTo(size.width - widthClip, 0);
    path.lineTo(size.width, widthClip);
    path.lineTo(size.width, size.height - widthClip);
    path.lineTo(size.width - widthClip, size.height);
    path.lineTo(widthClip, size.height);
    path.lineTo(0, size.height - widthClip);
    path.lineTo(0, widthClip);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ButtonUpLY1Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double clipWidth = 4;
    path.moveTo(0, clipWidth);
    path.lineTo(clipWidth, 0);
    path.lineTo(size.width - clipWidth, 0);
    path.lineTo(size.width, clipWidth);
    path.lineTo(size.width, size.height - clipWidth);
    path.lineTo(size.width - clipWidth, size.height);
    path.lineTo(clipWidth, size.height);
    path.lineTo(0, size.height - clipWidth);
    path.lineTo(0, clipWidth);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ButtonUpLY2Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double clipWidth = size.width * .2;
    double heightSteep = 3;
    double weightClip = 1;
    path.moveTo(clipWidth, size.height);
    path.lineTo(clipWidth + heightSteep, size.height - heightSteep - weightClip);
    path.lineTo(size.width - (clipWidth + heightSteep), size.height - heightSteep - weightClip);
    path.lineTo(size.width - clipWidth, size.height);
    path.lineTo(size.width - clipWidth - weightClip, size.height);
    path.lineTo(size.width - clipWidth - weightClip - heightSteep, size.height - heightSteep);
    path.lineTo(clipWidth + heightSteep + weightClip, size.height - heightSteep);
    path.lineTo(clipWidth + weightClip, size.height);
    path.lineTo(clipWidth, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ButtonUpLY3Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double clipWidth = 4;
    double clipWidthBottom = size.width * .2 - 3;
    double heightSteep = 4;
    path.moveTo(0, clipWidth);
    path.lineTo(clipWidth, 0);
    path.lineTo(size.width - clipWidth, 0);
    path.lineTo(size.width, clipWidth);
    path.lineTo(size.width, size.height - clipWidth);
    path.lineTo(size.width - clipWidth, size.height);
    path.lineTo(size.width - clipWidthBottom, size.height);
    path.lineTo(size.width - clipWidthBottom - heightSteep, size.height - heightSteep);
    path.lineTo(clipWidthBottom + heightSteep, size.height - heightSteep);
    path.lineTo(clipWidthBottom, size.height);
    path.lineTo(clipWidth, size.height);
    path.lineTo(0, size.height - clipWidth);
    path.lineTo(0, clipWidth);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ButtonUpLY4Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double clipWidth = 2;
    path.lineTo(clipWidth, 0);
    path.lineTo(clipWidth, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    path.moveTo(size.width, 0);
    path.lineTo(size.width - clipWidth, 0);
    path.lineTo(size.width - clipWidth, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
