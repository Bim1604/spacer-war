import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spacer_shooter/spacer/settings.dart';
import 'package:provider/provider.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Padding(
              padding:  EdgeInsets.symmetric(vertical: 35.0),
              child: Text("Settings", style: TextStyle(
                fontSize: 50,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.white,
                    offset: Offset(0, 0)
                  )]
              )),
            ),
            Selector<Setting, bool>(
              selector: (context, settings) {
                return settings.soundEffects;
              },
              builder: (context, value, child) {
                return SwitchListTile(
                  value: value,
                  title: const Text("Sound effects"),
                  onChanged: (newValue) {
                  Provider.of<Setting>(context, listen: false).soundEffects = newValue;
                });
              },
            ),
            Selector<Setting, bool>(
              selector: (context, settings) {
                return settings.backGroundMusic;
              },
              builder: (context, value, child) {
                return SwitchListTile(
                  value: value,
                  title: const Text("Background Music"),
                  onChanged: (newValue) {
                  Provider.of<Setting>(context, listen: false).backGroundMusic = newValue;
                });
              },
            ),
            SizedBox(
              width: size.width / 3,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Icon(Icons.chevron_left, size: 23, color: Colors.white)
              ),
            ),
          ]
        )
      )
    );
  }
}