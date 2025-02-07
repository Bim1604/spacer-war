import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/components/button/button_default.Component.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';

class AlertDefault {
  static void showAlertDefault(BuildContext context, {String title = "", String content = "", Color color = Colors.green}) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: color,
        title: Text(title, style: const TextStyle(fontFamily: "", ), textAlign: TextAlign.center,),
        content: Text(content, style: const TextStyle(fontFamily: "", ), textAlign: TextAlign.center,),
      );
    });
  }

  static Future<bool> showConfirmDefault(BuildContext context, {String title = "",String denyTitle = "", String agreeTitle = "", Function()? confirm, String content = "", Color color = Colors.green}) async {
    Size size = MediaQuery.of(context).size;
    var result  = await showDialog(context: context, builder: (context) {
      return Dialog(
        backgroundColor: color,
        child: SizedBox(
          width: size.width * 0.4,
          height: size.height * .5,
          child: Column(
            children: [
              Text(title, style: TextStyle(fontFamily: "", fontSize: 17, color: AppColor.white), textAlign: TextAlign.center),
              const SizedBox(height: 20.0),
              Text(content, style: TextStyle(fontFamily: "", fontSize: 13, color: AppColor.white), textAlign: TextAlign.center),
              const SizedBox(height: 20.0),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: ButtonDefaultComponent(title: denyTitle, callback: (){
                        Navigator.pop(context);
                      },
                        textStyle: TextStyle(fontSize: 13, color: AppColor.white),
                        gradient: LinearGradient(colors: [
                          AppColor.neonRed,
                          AppColor.neonRed,
                        ]),
                        height: 30,
                        width: 90,
                      )
                    ),
                    const SizedBox(width: 20.0),
                    Material(
                      color: Colors.transparent,
                      child: ButtonDefaultComponent(title: agreeTitle, callback: (){
                        Navigator.pop(context, true);
                      },
                        textStyle: TextStyle(fontSize: 13, color: AppColor.white),
                        gradient: LinearGradient(colors: [
                          AppColor.springGreen,
                          AppColor.lime,
                          AppColor.springGreen,
                          AppColor.lime,
                          AppColor.springGreen,
                        ]),
                        height: 30,
                        width: 120,
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
    return result;
  }
}