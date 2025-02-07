import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';

class ButtonDefaultComponent extends StatelessWidget {
  const ButtonDefaultComponent({super.key, required this.title, this.callback, this.width, this.height, this.gradient, this.slashColor, this.textStyle});
  final String title; 
  final Function()? callback;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final Color? slashColor;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              width: width ?? size.width / 5,
              height: height ?? 43,
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.clamp,
                  colors: [Colors.white, Colors.grey],
                )
              ),
            ),
          ),
          Positioned(
            top: 1,
            left: 3,
            child: ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                decoration: BoxDecoration(
                  color: slashColor ?? Colors.blueAccent,
                ),
                width: (width ?? size.width / 5) - 6,
                height: (height ?? 43) - 3,
              ),
            ),
          ),
          Positioned(
            top: 3,
            left: 5.5,
            child: ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: gradient ?? const LinearGradient(
                    colors: [
                      Color(0xFF003060),
                      Color(0xFF055C9D),
                      Color(0xFF62cff4),
                      Color(0xFF055C9D),
                      Color(0xFF003060),
                    ]
                  ),
                ),
                width: (width ?? size.width / 5) - 11,
                height: (height ?? 43) - 7,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap:(){
                      if (callback != null) {
                        callback!();
                      }
                    },
                    splashColor: slashColor ?? AppColor.deepSky,
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width,
                      height: size.height,
                      child: Text(title, style:textStyle ?? const TextStyle(fontFamily: 'Game', fontSize: 24, color: Colors.white), textAlign: TextAlign.center,)
                    )
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

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double widthSharp = size.width / 6;
    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(widthSharp, size.height);
    path.lineTo(size.width - widthSharp, size.height);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - widthSharp, 0);
    path.lineTo(widthSharp, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}