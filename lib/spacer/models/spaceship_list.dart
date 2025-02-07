import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:spacer_shooter/spacer/data/data.dart';
import 'package:spacer_shooter/spacer/models/spaceship_details.dart';
import 'package:spacer_shooter/spacer/models/spaceship_types.dart';

part 'spaceship_list.g.dart';

@HiveType(typeId: 5)
class SpaceshipList extends ChangeNotifier with HiveObjectMixin {
  @HiveField(0)
  List<Spaceship> listSpaceship;

  SpaceshipList({
    required this.listSpaceship,
  });

  SpaceshipList.fromMap(Map<String, dynamic> map) : listSpaceship = map['listSpaceship'] ?? getListSpaceshipDefault();

  static SpaceshipList getListSpaceshipDefault() {
    SpaceshipList result = SpaceshipList(listSpaceship: []);
    try {
      List<Spaceship> listShip = List.empty(growable: true);
      listShip.add(Spaceship.getSpaceShipByType(SpaceshipTypes.Pilot));
      listShip.add(Spaceship.getSpaceShipByType(SpaceshipTypes.Knight));
      listShip.add(Spaceship.getSpaceShipByType(SpaceshipTypes.CXC));
      listShip.add(Spaceship.getSpaceShipByType(SpaceshipTypes.Raptor));
      result.listSpaceship = listShip;
    } catch (e) {
      print(e);
    }
    return result;
  }

  static Future<SpaceshipList> getListSpaceship() async {
    SpaceshipList result = SpaceshipList(listSpaceship: []);
    List<Spaceship> listTemp = List.empty(growable: true);
    try {
      final box = await Hive.openBox<List<Spaceship>>(DataLocalLink.dataListSpaceshipBox);
      List<Spaceship>? listShip = box.get(ObjectData.listSpaceship);
      if (listShip == null) {
        listTemp = getListSpaceshipDefault().listSpaceship;
      } else {
        listTemp = listShip;
      }
      result.listSpaceship = listTemp;
    } catch (e) {
      print(e);
    }
    return result;
  }

  static Future<Spaceship> getSpaceshipById(String id) async {
    Spaceship spaceship = Spaceship.getSpaceShipByType(SpaceshipTypes.Pilot);
    try {
      final box = await Hive.openBox<List<Spaceship>>(DataLocalLink.dataListSpaceshipBox);
      List<Spaceship>? listShip = box.get(ObjectData.listSpaceship);
      if (listShip != null && listShip.isNotEmpty) {
        int indexFinding = listShip.indexWhere((ship) => ship.id == id);
        if (indexFinding > - 1) {
          spaceship = listShip[indexFinding];
        }
      }
    } catch (e) {
      print(e);
    }
    return spaceship;
  }

  Future<void> saveSpaceship(Spaceship spaceship) async {
    try {
      final box = await Hive.openBox<SpaceshipList>(DataLocalLink.dataListSpaceshipBox);
      SpaceshipList? listShip = box.get(ObjectData.listSpaceship);
      if (listShip != null && listShip.listSpaceship.isNotEmpty) {
        int indexFinding = listShip.listSpaceship.indexWhere((ship) => ship.id == spaceship.id);
        if (indexFinding > -1) {
          listShip.listSpaceship[indexFinding] = spaceship;
        }
      } else {
        listShip = getListSpaceshipDefault();
      }
      notifyListeners();
      await box.put(ObjectData.listSpaceship, listShip);
    } catch (e) {
      print(e);
    }
  }


}
