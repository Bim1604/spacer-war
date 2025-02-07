import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/models/playerData.dart';
import 'package:spacer_shooter/spacer/models/spaceship_details.dart';
import 'package:spacer_shooter/spacer/models/spaceship_list.dart';
import 'package:spacer_shooter/spacer/screens/select_ship/elements/select_ship.Element.dart';
import 'package:spacer_shooter/spacer/screens/select_ship/elements/space_ship_type.dart';
import 'package:spacer_shooter/spacer/screens/main_menu.dart';
import 'package:provider/provider.dart';
import 'package:spacer_shooter/spacer/models/spaceship_types.dart';

class SelectSpaceShip extends StatefulWidget {
  const SelectSpaceShip({super.key});

  @override
  State<SelectSpaceShip> createState() => _SelectSpaceShipState();
}

class _SelectSpaceShipState extends State<SelectSpaceShip> {
  Spaceship spaceshipSelect = Spaceship.getSpaceShipByType(SpaceshipTypes.Pilot);
  List<SpaceshipTypes> listOwnedShip = List.empty(growable: true);
  SpaceshipList listShip = SpaceshipList(listSpaceship: []);
  late PlayerData playerData;

  @override
  void initState() {
    playerData = Provider.of<PlayerData>(context, listen: false);
    listShip = Provider.of<SpaceshipList>(context, listen: false);
    listOwnedShip = playerData.ownedSpaceships;
    for (var ship in playerData.ownedSpaceships) {
      if (playerData.isEquipped(ship)) {
        if (mounted) {
          setState(() {
            spaceshipSelect = Spaceship.getSpaceShipByType(ship);
          });
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AssetsSpacer.background), fit: BoxFit.cover)
        ),
        padding: const EdgeInsets.all(5.0),
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
           Positioned(
            top: size.height / 50,
            left: 2,
             child: SizedBox(
                 width: 30,
                 child: IconButton(
                  icon: const Icon(Icons.chevron_left, size: 23, color: Colors.white),
                   onPressed: (){
                     Navigator.of(context).pushReplacement(
                       MaterialPageRoute(builder: (context) => const MainMenu())
                     );
                   }
                 ),
               ),
           ),
            Container(
              height: size.height,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * .25,
                    alignment: Alignment.bottomLeft,
                    height: size.height * .65,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: listOwnedShip.length,
                      itemBuilder: (BuildContext context, int index) {
                        Spaceship spaceship = Spaceship.getSpaceShipByType(listOwnedShip[index]);
                        return SpaceShipTypeSelect(
                          thumbnail: spaceship.thumbnail,
                          fireType: spaceship.typeFire,
                          name: spaceship.name,
                          isSelected: playerData.isEquipped(listOwnedShip[index]) ? true : false,
                          callback: () {
                            playerData.equip(listOwnedShip[index]);
                            if (mounted) {
                              setState(() {
                                spaceshipSelect = Spaceship.getSpaceShipByType(listOwnedShip[index]);
                              });
                            }
                          },
                        );
                      }
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * .5,
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Image.asset(spaceshipSelect.thumbnail, fit: BoxFit.cover,)
                          ),
                        ),
                      ]
                    ),
                  ),
                  SizedBox(
                    width: size.width * .32,
                    child: Consumer<PlayerData>(
                      builder: (context, playerData, child) {
                        spaceshipSelect = listShip.listSpaceship.firstWhere((element) => element.id == spaceshipSelect.id);
                        return SelectShipElement(spaceshipSelect: spaceshipSelect,);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}