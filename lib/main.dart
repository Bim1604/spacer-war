import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:spacer_shooter/spacer/data/data.dart';
import 'package:spacer_shooter/spacer/models/attribute.dart';
import 'package:spacer_shooter/spacer/models/planet.dart';
import 'package:spacer_shooter/spacer/models/planet_list.dart';
import 'package:spacer_shooter/spacer/models/playerData.dart';
import 'package:spacer_shooter/spacer/models/position_planet.dart';
import 'package:spacer_shooter/spacer/models/skill.dart';
import 'package:spacer_shooter/spacer/models/spaceship_details.dart';
import 'package:spacer_shooter/spacer/models/spaceship_list.dart';
import 'package:spacer_shooter/spacer/screens/main_menu.dart';
import 'package:spacer_shooter/spacer/settings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:spacer_shooter/spacer/models/spaceship_types.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  await initHive();
  runApp(
    MultiProvider(
      providers: [
        FutureProvider<PlayerData>(
          create: (context) => getPlayerData(),
          initialData: PlayerData.fromMap(PlayerData.defaultData),
        ),
        FutureProvider<Spaceship>(
          create: (context) => getDataShip(),
          initialData: Spaceship.getAllSpaces().first,
        ),
        FutureProvider<SpaceshipList>(
          create: (context) => getListDataShip(),
          initialData: SpaceshipList.getListSpaceshipDefault(),
        ),
        FutureProvider<PlanetList>(
          create: (context) => getListDataPlanet(),
          initialData: await PlanetList.getPlanetDataListDefault(),
        ),
        FutureProvider<Setting>(
          create: (context) => getSettings(),
          initialData: Setting(backGroundMusic: false, soundEffects: false),
        ),
      ],
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<PlayerData>.value(
              value: Provider.of<PlayerData>(context),
            ),
            ChangeNotifierProvider<SpaceshipList>.value(
              value: Provider.of<SpaceshipList>(context),
            ),
            ChangeNotifierProvider<Spaceship>.value(
              value: Provider.of<Spaceship>(context),
            ),
            ChangeNotifierProvider<Setting>.value(
              value: Provider.of<Setting>(context),
            ),
            ChangeNotifierProvider<PlanetList>.value(
              value: Provider.of<PlanetList>(context),
            ),
          ],
          child: child,
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          fontFamily: 'Game',
          scaffoldBackgroundColor: Colors.black,
        ),
        home:  const MainMenu()
      ),
    )
  );
}

Future<void> initHive() async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    Hive.registerAdapter(PlayerDataAdapter());
    Hive.registerAdapter(SettingAdapter());
    Hive.registerAdapter(SpaceshipTypesAdapter());
    Hive.registerAdapter(SpaceshipAdapter());
    Hive.registerAdapter(AttributeAdapter());
    Hive.registerAdapter(SkillModelAdapter());
    Hive.registerAdapter(SpaceshipListAdapter());
    Hive.registerAdapter(PlanetComponentAdapter());
    Hive.registerAdapter(PositionPlanetAdapter());
    Hive.registerAdapter(PlanetListAdapter());
  } catch (e) {
    print(e);
  }
}

Future<PlayerData> getPlayerData() async {
  PlayerData player = PlayerData.getPlayerDataDefault();
  try {
    final box = await  Hive.openBox<PlayerData>(DataLocalLink.dataPlayerBox);
    final playerData = box.get(ObjectData.dataPlayer);
    if (playerData == null) {
      box.put(ObjectData.dataPlayer, PlayerData.fromMap(PlayerData.defaultData));
      player = box.get(ObjectData.dataPlayer)!;
    } else {
      if (playerData.ownedSpaceships.isEmpty) {
        playerData.ownedSpaceships.add(SpaceshipTypes.Pilot);
      }
      await playerData.save();
      player = playerData;
    }
  } catch (e) {
    print(e);
  }
  return player;
}

Future<Spaceship> getDataShip() async {
  final box = await Hive.openBox<Spaceship>(DataLocalLink.dataListShipBox);
  try {
    final listShipData = box.get(ObjectData.listShip);
    if (listShipData == null) {
      await box.put(ObjectData.listShip, Spaceship.getAllSpaces().first);
    }
  } catch (e) {
    print(e);
  }
  return box.get(ObjectData.listShip)!;
}

Future<SpaceshipList> getListDataShip() async {
  SpaceshipList result = SpaceshipList.getListSpaceshipDefault();
  try {
    final box = await Hive.openBox<SpaceshipList>(DataLocalLink.dataListSpaceshipBox);
    final listShipData = box.get(ObjectData.listSpaceship);
    if (listShipData == null) {
      await box.put(ObjectData.listSpaceship, SpaceshipList.getListSpaceshipDefault());
    } else {
      result = listShipData;
    }
  } catch (e) {
    print(e);
  }
  return result;
}

Future<PlanetList> getListDataPlanet() async {
  PlanetList result = await PlanetList.getPlanetDataListDefault();
  try {
    final box = await Hive.openBox<PlanetList>(DataLocalLink.dataListPlanetBox);
    final listPlanetData = box.get(ObjectData.listPlanet);
    if (listPlanetData == null) {
      result = await PlanetList.getPlanetDataListDefault();
      await box.put(ObjectData.listPlanet, result);
    } else {
      result = listPlanetData;
    }
  } catch (e) {
    print(e);
  }
  return result;
}

Future<Setting> getSettings() async {
  final box = await  Hive.openBox<Setting>(DataLocalLink.settingBox);
  final settings = box.get(ObjectData.settingKey);
  if (settings == null) {
    box.put(ObjectData.settingKey, Setting(backGroundMusic: true, soundEffects: true));
  }
  return box.get(ObjectData.settingKey)!;
}