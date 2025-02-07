import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';
import 'package:spacer_shooter/spacer/models/playerData.dart';
import 'package:spacer_shooter/spacer/screens/shop/elements/currency_item.Element.dart';

class CurrencyListElement extends StatefulWidget {
  const CurrencyListElement({super.key, this.width, this.height, required this.playerData});
  final double? width;
  final double? height;
  final PlayerData playerData;

  @override
  State<CurrencyListElement> createState() => _CurrencyListElementState();
}

class _CurrencyListElementState extends State<CurrencyListElement> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double widthScale = widget.width ?? size.width * .45;
    double heightScale = widget.height ?? 55;
    return Stack(
      children: [
        ClipPath(
          clipper: ClipShapeCurrencyV1(),
          child: Container(
            width: widthScale,
            height: heightScale,
            decoration: BoxDecoration(
              color: AppColor.wisteria,
            ),
            child: ClipPath(
              clipper: ClipShapeCurrencyV2(),
              child: Container(
                width: size.width,
                height: heightScale,
                color: AppColor.dodgerBlue,
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  width: size.width,
                  height: heightScale,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor.platinumBlue,
                        AppColor.midnightBlue,
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CurrencyItem(icon: AssetsSpacer.coin, button: AssetsSpacer.add, content: widget.playerData.money.toString()),
                      const SizedBox(width: 10.0),
                      CurrencyItem(icon: AssetsSpacer.sapphire, button: AssetsSpacer.add, content:  widget.playerData.diamond.toString(), ),
                    ],
                  )
                ),
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: ClipShapeCurrencyV4(),
          child: Container(
            width: widthScale,
            height: heightScale,
            decoration: BoxDecoration(
              color: AppColor.gunmetalGray,
            ),
          ),
        )
      ],
    );
  }
}

class ClipShapeCurrencyV1 extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();
    double widthClipTop = size.width * .15;
    double widthClipBot = size.width * .12 - 8;
    double heightSteep = 5;
    double widthSteep = 7;
    path.lineTo(widthClipTop, 0);
    path.arcToPoint(Offset(widthClipTop + widthSteep, heightSteep), radius: const Radius.circular(30));
    path.lineTo(size.width - widthClipTop - widthSteep, heightSteep);
    path.arcToPoint(Offset(size.width - widthClipTop, 0), radius: const Radius.circular(30));
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - widthClipBot, size.height);
    path.lineTo(size.width - widthClipBot - widthSteep, size.height - heightSteep);
    path.lineTo(widthClipBot + widthSteep, size.height - heightSteep);
    path.lineTo(widthClipBot, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}

class ClipShapeCurrencyV2 extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();
    double widthClipTop = size.width * .15;
    double widthClipBot = size.width * .12;
    double heightSteep = 5;
    double widthSteep = 7;
    path.moveTo(widthClipTop, 0);
    path.lineTo(widthClipTop + widthSteep, heightSteep);
    path.lineTo(size.width - widthClipTop - widthSteep, heightSteep);
    path.lineTo(size.width - widthClipTop, 0);
    path.cubicTo(size.width - (widthClipBot / 3), heightSteep / 4, size.width - widthClipBot / 1.25, size.height,  size.width - widthClipBot / 1.2,size.height);
    path.lineTo(size.width - widthClipBot - widthSteep, size.height - heightSteep);
    path.lineTo(widthClipBot / 1.2 + widthSteep, size.height - heightSteep);
    path.lineTo(widthClipBot / 1.2, size.height);
    path.cubicTo(widthClipBot / 1.25, size.height, (widthClipBot / 3), heightSteep / 4, widthClipTop, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}

class ClipShapeCurrencyV4 extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();
    double widthClipBot = size.width * .12;
    double heightClipBody = size.height * .16;
    double heightClipTop = size.height * .12;
    double heightClipBot = size.height * .12;
    double paddingClip = 2;
    // left
    path.moveTo(paddingClip, heightClipBody);
    path.lineTo(widthClipBot / 1.25 - 4, heightClipBody);
    path.quadraticBezierTo(widthClipBot / 2, size.height / 2, widthClipBot / 1.25 - 5, size.height - heightClipBody);
    path.lineTo(paddingClip, size.height - heightClipBody);
    path.lineTo(paddingClip, heightClipBody);

    path.moveTo(paddingClip, paddingClip);
    path.lineTo(widthClipBot - 3, paddingClip);
    path.quadraticBezierTo(widthClipBot / 1.25, heightClipTop / 2, widthClipBot - 10, heightClipTop);
    path.lineTo(paddingClip, heightClipTop);
    path.lineTo(paddingClip, paddingClip);

    path.moveTo(paddingClip, size.height - heightClipBot);
    path.lineTo(widthClipBot - 11, size.height - heightClipBot);
    path.quadraticBezierTo(widthClipBot / 1.25, size.height - paddingClip / 2, widthClipBot - 7,size.height - paddingClip);
    path.lineTo(paddingClip, size.height - paddingClip);
    path.lineTo(paddingClip, size.height - heightClipBot);

    //right
    path.moveTo(size.width - paddingClip, heightClipBody);
    path.lineTo(size.width - (widthClipBot / 1.25 - 4), heightClipBody);
    path.quadraticBezierTo( size.width - (widthClipBot / 2), size.height / 2, size.width - (widthClipBot / 1.25 - 5), size.height - heightClipBody);
    path.lineTo(size.width - paddingClip, size.height - heightClipBody);
    path.lineTo(size.width - paddingClip, heightClipBody);

    path.moveTo(size.width - paddingClip, paddingClip);
    path.lineTo(size.width - (widthClipBot - 3), paddingClip);
    path.quadraticBezierTo(size.width - (widthClipBot / 1.25), heightClipTop / 2, size.width - (widthClipBot - 10), heightClipTop);
    path.lineTo(size.width - paddingClip, heightClipTop);
    path.lineTo(size.width - paddingClip, paddingClip);

    path.moveTo(size.width - paddingClip, size.height - heightClipBot);
    path.lineTo(size.width - (widthClipBot - 11), size.height - heightClipBot);
    path.quadraticBezierTo(size.width - (widthClipBot / 1.25), size.height - paddingClip / 2, size.width - (widthClipBot - 7),size.height - paddingClip);
    path.lineTo(size.width - paddingClip, size.height - paddingClip);
    path.lineTo(size.width - paddingClip, size.height - heightClipBot);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ClipItemCurrency extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();
    double heightClip = size.height * .2;
    path.moveTo(0, heightClip);
    // path.lineTo(size.width, y)
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}