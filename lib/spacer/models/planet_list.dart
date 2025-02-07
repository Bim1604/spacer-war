import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/data/data.dart';
import 'package:spacer_shooter/spacer/models/planet.dart';
import 'package:hive/hive.dart';
import 'package:spacer_shooter/spacer/models/position_planet.dart';

part 'planet_list.g.dart';

@HiveType(typeId: 7)
class PlanetList extends ChangeNotifier with HiveObjectMixin{
  
  @HiveField(0)
  List<PlanetComponent> listPlanet;

  PlanetList({
   required this.listPlanet,
  });

  PlanetList.fromMap(Map<String, dynamic> map) : listPlanet = map['listPlanet'] ?? getPlanetDataListDefault();

  static Future<PlanetList> getPlanetDataListDefault() async {
    PlanetList result = PlanetList(listPlanet: []);
    try {
      List<PlanetComponent> listTemp = List.empty(growable: true);
      listTemp.add(PlanetComponent(1, "MAP 1", star: 2, isLock: false, spriteString: AssetsSpacer.planet1, positionPlanet: PositionPlanet(x: 830.4 * 0.1, y:384.0 * 0.6)));
      listTemp.add(PlanetComponent(2, "MAP 2", star: 1, isLock: false, spriteString: AssetsSpacer.planet2, positionPlanet: PositionPlanet(x: 830.4 * 0.3, y: 384.0 * 0.45)));
      listTemp.add(PlanetComponent(3, "MAP 3", star: 0, isLock: true, spriteString: AssetsSpacer.planet3, positionPlanet: PositionPlanet(x: 830.4 * 0.5, y: 384.0 * 0.55)));
      listTemp.add(PlanetComponent(4, "MAP 4", star: 0, isLock: true, spriteString: AssetsSpacer.planet4, positionPlanet: PositionPlanet(x: 830.4 * 0.7, y: 384.0 * 0.6)));
      listTemp.add(PlanetComponent(5, "MAP 5", star: 0, isLock: true, spriteString: AssetsSpacer.planet5, positionPlanet: PositionPlanet(x: 830.4 * 0.8, y: 384.0 * 0.3)));
      listTemp.add(PlanetComponent(6, "MAP 6", star: 0, isLock: true, spriteString: AssetsSpacer.planet6, positionPlanet: PositionPlanet(x: 830.4 * 0.6, y: 384.0 * 0.1)));
      result.listPlanet = listTemp;
    } catch (e) {
      print(e);
    }
    return result;
  }

  static Future<PlanetList> getPlanetDataList() async {
    PlanetList result = PlanetList(listPlanet: []);
    List<PlanetComponent> listTemp = List.empty(growable: true);
    try {
      final box = await Hive.openBox<PlanetList>(DataLocalLink.dataListPlanetBox);
      PlanetList? listPlanet = box.get(ObjectData.listPlanet);
      if (listPlanet == null) {
        listTemp = (await getPlanetDataListDefault()).listPlanet;
      } else {
        listTemp = listPlanet.listPlanet;
      }
      result.listPlanet = listTemp;
    } catch (e) {
      print(e);
    }
    return result;
  }

  static Future<PlanetComponent> getPlanetById(int id) async {
    PlanetComponent spaceship = PlanetComponent(1, "MAP 1", spriteString: AssetsSpacer.planet1, positionPlanet: PositionPlanet(x: 0, y: 0));
    try {
      final box = await Hive.openBox<PlanetList>(DataLocalLink.dataListPlanetBox);
      PlanetList? listTemp = box.get(ObjectData.listPlanet);
      if (listTemp != null) {
        int indexFinding = listTemp.listPlanet.indexWhere((planet) => planet.id == id);
        if (indexFinding > - 1) {
          spaceship = listTemp.listPlanet[indexFinding];
        }
      }
    } catch (e) {
      print(e);
    }
    return spaceship;
  }

  Future<void> savePlanet(PlanetComponent planet) async {
    try {
      final box = await Hive.openBox<PlanetList>(DataLocalLink.dataListPlanetBox);
      PlanetList? listPlanet = box.get(ObjectData.listPlanet);
      if (listPlanet != null) {
        int indexFinding = listPlanet.listPlanet.indexWhere((item) => item.id == planet.id);
        if (indexFinding > -1) {
          listPlanet.listPlanet[indexFinding] = planet;
        }
      } else {
        listPlanet = await getPlanetDataListDefault();
      }
      notifyListeners();
      await box.put(ObjectData.listPlanet, listPlanet);
    } catch (e) {
      print(e);
    }
  }
}
