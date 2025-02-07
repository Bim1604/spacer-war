import 'package:flutter/material.dart';
import 'package:spacer_shooter/spacer/assets/assets_spacer.dart';
import 'package:spacer_shooter/spacer/components/app/alert.Component.dart';
import 'package:spacer_shooter/spacer/components/button/diamon_button.Component.dart';
import 'package:spacer_shooter/spacer/config/app_color.dart';
import 'package:spacer_shooter/spacer/config/app_key.dart';
import 'package:spacer_shooter/spacer/models/attribute.dart';
import 'package:spacer_shooter/spacer/models/playerData.dart';
import 'package:spacer_shooter/spacer/models/spaceship_details.dart';
import 'package:spacer_shooter/spacer/models/spaceship_list.dart';
import 'package:spacer_shooter/spacer/models/spaceship_types.dart';
import 'package:spacer_shooter/spacer/screens/select_ship/elements/space_ship_type.dart';
import 'package:spacer_shooter/spacer/screens/shop/elements/attribute_upgrade.Element.dart';
import 'package:spacer_shooter/spacer/screens/shop/elements/currency_list.Element.dart';
import 'package:spacer_shooter/spacer/screens/shop/elements/information_player.Element.dart';
import 'package:spacer_shooter/spacer/screens/shop/elements/tab_shop.Element.dart';
import 'package:provider/provider.dart';

class ShopMainScreen extends StatefulWidget {
  const ShopMainScreen({super.key});

  @override
  State<ShopMainScreen> createState() => _SShopMainScreenState();
}

class _SShopMainScreenState extends State<ShopMainScreen> {
  Spaceship spaceshipSelect = Spaceship.getSpaceShipByType(SpaceshipTypes.Pilot);
  SpaceshipList listSpacerShip = SpaceshipList(listSpaceship: []);
  late PlayerData playerData;
  bool isOwn = false;
  String tabSelect = AppKey.tabShip;
  
  @override
  void initState() {
    playerData = Provider.of<PlayerData>(context, listen: false);
    listSpacerShip = Provider.of<SpaceshipList>(context, listen: false);
    spaceshipSelect = listSpacerShip.listSpaceship.first;
    isOwn = playerData.isOwned(Spaceship.getTypeByShip(spaceshipSelect));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AssetsSpacer.backgroundShop), fit: BoxFit.fill)
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: size.width * .2,
              top: 0,
              child: Consumer<SpaceshipList>(
                builder: (context, shipList, child) {
                  Spaceship data = shipList.listSpaceship.firstWhere((element) => element.id == spaceshipSelect.id); 
                  return InformationPlayer(
                    canBuy: playerData.canBuy(Spaceship.getTypeByShip(data)),
                    spaceshipSelect: data,
                    isOwn: isOwn,
                    callback: () async {                      
                      if (isOwn) {
                        // playerData.money = 200000;
                        // playerData.save();
                        // Upgrade
                        bool canUpgrade = true;
                        for (var att in data.listAttribute) {
                          if (att.level < att.levelMax) {
                            canUpgrade = false;
                          }
                        }
                        if (canUpgrade) {
                          bool result =  await AlertDefault.showConfirmDefault(context, title: "Upgrade ${data.name}", denyTitle: "Not Now", agreeTitle: "Upgrade", 
                            color: AppColor.forestGreen, 
                            content: "Do you want to upgrade ${data.name} from level ${data.currentLevel} to ${data.currentLevel + 1}?\nNeed ${data.currentCostUpgrade} coin",
                            confirm: (){

                          });
                          if (result) {
                            data.currentLevel++;
                            playerData.money = playerData.money - data.currentCostUpgrade;
                            data.currentCostUpgrade = Spaceship.getCostPerLevel(data.currentCostUpgrade, level: data.currentLevel);
                            for (var item in data.listAttribute) {
                              item.level = 0;
                              item.levelUpgrade++;
                              item.currentPoint = item.currentPoint + item.pointPerLevel;
                            }
                            await shipList.saveSpaceship(data);
                            playerData.saveMoney(playerData.money);
                          }
                        } else {
                          AlertDefault.showAlertDefault(context, title: "Can't upgrade",  content: "Upgrade all attributes before upgrading your character", color: AppColor.darkGray);
                        }
                      } else {
                        // Buy
                        final canBuy = playerData.canBuy(Spaceship.getTypeByShip(data));
                        if (canBuy) {
                          playerData.buy(Spaceship.getTypeByShip(data));
                          AlertDefault.showAlertDefault(context, title: "Buy ${data.name} successfully",  content: "Thanks for buying!\nWish you use ${data.name} effectively", color: AppColor.forestGreen);
                          setState(() {
                            isOwn = playerData.isOwned(Spaceship.getTypeByShip(data));
                          });
                        } else {
                          AlertDefault.showAlertDefault(context, title: "Can't buy ${data.name}",  content: "Need ${data.cost - playerData.money} coin more", color: AppColor.neonRed);
                        }
                      }
                    },
                  );
                },
              ),
            ),
            Positioned(
              left: 10,
              top: size.height * .3,
              child: SizedBox(
                width: size.width * .15,
                height: size.height * .25,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: listSpacerShip.listSpaceship.length,
                  itemBuilder: (BuildContext context, int index) {
                    Spaceship spaceship = listSpacerShip.listSpaceship[index];
                    return SpaceShipTypeSelect(
                      height: 30,
                      width: 50,
                      isHideSpecial: true,
                      thumbnail: spaceship.thumbnail,
                      fireType: spaceship.typeFire,
                      name: spaceship.name,
                      isSelected: spaceshipSelect.id == spaceship.id ? true : false,
                      callback: () async {
                        if (mounted) {
                          try {
                            setState(() {
                              spaceshipSelect = listSpacerShip.listSpaceship[index];
                              isOwn = playerData.isOwned(Spaceship.getTypeByShip(spaceshipSelect));
                            });
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                    );
                  }
                ),
              ),
            ),
            Positioned(
              right: size.width * .1,
              top: size.height * .2,
              child: Container(
                alignment: Alignment.center,
                height: size.height * .4,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(spaceshipSelect.thumbnail, fit: BoxFit.contain, height: size.height * .4, width: size.width * .3)
                ),
              ),
            ),
            Positioned(
              right:0,
              child: SizedBox(
                height: size.height,
                child: buildTabBarRight(
                  tabSelect: tabSelect,
                  callback: (tab) {
                    if (mounted) {
                      setState(() {
                        tabSelect = tab;
                      });
                    }
                  },
                )
              )
            ),
            Positioned(
              top: size.height * .1,
              left: size.width * .05,
              child: DiamondButtonComponent(
                callBack: (){
                  Navigator.pop(context);
                },
                icon: Icons.chevron_left,
              )
            ),
            Positioned(
              top: size.height * .02,
              right: size.width * .03,
              child: Consumer<PlayerData>(
                builder: (context, data, child) {
                  return CurrencyListElement(
                    playerData: data,
                  );
                },
              )
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: size.height * .6, right: 20, bottom: 5),
              width: size.width * .85,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<SpaceshipList>(
                  builder: (context, shipList, child) {
                    Spaceship data = shipList.listSpaceship.firstWhere((element) => element.id == spaceshipSelect.id);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: data.listAttribute.map((attribute) {
                        return Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          height: 130,
                          child: AttributeUpgradeElement(
                            attribute: attribute,
                            callback: (att) async {
                              if (isOwn) {
                                // playerData.saveMoney(1000000);
                                // Not enough money
                                if (att.costUpgrade > playerData.money) {
                                  AlertDefault.showAlertDefault(context, title: "Can't upgrade ${att.name}", content: "Need ${att.costUpgrade - playerData.money} coin to upgrade ${att.name}", color: AppColor.neonRed);
                                } else {
                                  // enough money to upgrade
                                  // reduce money player - increase money upgrade att - increase current point att
                                  int indexAtt = data.listAttribute.indexWhere((element) => element.id == att.id);
                                  if (indexAtt > -1) {
                                    Attribute attUpgrade = data.listAttribute[indexAtt];
                                    if (attUpgrade.level < attUpgrade.levelMax) {
                                      attUpgrade.level++;
                                      attUpgrade.currentPoint = attUpgrade.currentPoint + attUpgrade.pointPerLevel;
                                      playerData.money = playerData.money - attUpgrade.costUpgrade;
                                      playerData.saveMoney(playerData.money);
                                      attUpgrade.costUpgrade = attUpgrade.getCostUpgrade(attUpgrade.costUpgrade, data.currentLevel, data.id);
                                             
                                      await shipList.saveSpaceship(data);

                                    } else if (attUpgrade.level == attUpgrade.levelMax) {
                                      // attUpgrade.currentPoint = attUpgrade.level * attUpgrade.pointPerLevel;
                                      // attUpgrade.levelUpgrade++;
                                      // attUpgrade.level = 1;
                                      AlertDefault.showAlertDefault(context, title: "Can't upgrade ${att.name}", content: "To upgrade ${att.name}, upgrading ${data.name} first", color: AppColor.forestGreen);
                                    }
                                  }
                                }
                              } else {
                                AlertDefault.showAlertDefault(context, title: "Can't upgrade ${att.name} of ${data.name}", content: "Need buy ${data.name} first", color: AppColor.neonRed);
                              }
                            },
                          )
                        );
                      }).toList()
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildTabBarRight({Function(String)? callback, String tabSelect = ""}) {
    Widget result = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: Container()),
        const SizedBox(height: 15.0,),
        Expanded(
          child: TaBShopElement(
            iconString: AssetsSpacer.plane,
            isSelect: tabSelect == AppKey.tabShip,
            callBack: (){
              if (callback != null) {
                callback(AppKey.tabShip);
              }
            },
          )
        ),
        const SizedBox(height: 15.0,),
        Expanded(
          child: TaBShopElement(
            width: 30,
            height: 30,
            iconString: AssetsSpacer.drone,
            isSelect: tabSelect == AppKey.tabDrone,
            callBack: (){
              if (callback != null) {
                callback(AppKey.tabDrone);
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    backgroundColor: AppColor.gunmetalGray,
                    title: const Text("Alert information update", style: TextStyle(fontFamily: "", ), textAlign: TextAlign.center,),
                    content: const Text('The function is updating!', style: TextStyle(fontFamily: "", ), textAlign: TextAlign.center,),
                  );
                });
              }
            },
          )
        ),
        const SizedBox(height: 15.0,),
        Expanded(child: Container()),
      ],
    );
    return result;
  }
}