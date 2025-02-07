// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 2)
class Setting extends ChangeNotifier with HiveObjectMixin {
  @HiveField(0)
  bool _sfx = false;
  bool get soundEffects => _sfx;
  set soundEffects(bool value) {
    _sfx = value;
    notifyListeners();
    save();
  }

  @HiveField(1)
  bool _bgm = false;
  bool get backGroundMusic => _bgm;
  set backGroundMusic(bool value) {
    _bgm = value;
    notifyListeners();
    save();
  }

  Setting({
    bool soundEffects = false,
    bool backGroundMusic = false,
  }) : _sfx = soundEffects, _bgm = backGroundMusic;
  


}
