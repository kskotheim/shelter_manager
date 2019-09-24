import 'package:flutter/material.dart';
import 'package:shelter_manager/logic/base_logic.dart';
import 'package:shelter_manager/logic/game_logic.dart';
import 'package:shelter_manager/res/models/shelter.dart';
import 'package:shelter_manager/res/style.dart';

class ControlPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // sets the height based on the screen size
    double height = MediaQuery.of(context).size.height * .2;
    double width;

    // we can get the game logic instance by using the logic provider's '.of<x>' (of-type)
    // function, and the context, as long as it is a descendent of where the logic provider
    // sits in the widget tree
    GameLogic gameLogic = LogicProvider.of<GameLogic>(context);

    return Align(
      alignment: Alignment.bottomRight,
      child: StreamBuilder<ControlPanelState>(
          stream: gameLogic.controlPanelState,
          builder: (streamContext, snapshot) {
            if (!snapshot.hasData) return Container();
            if (snapshot.data is ControlPanelHidden) {
              width = 30.0;
              return Container(
                width: width,
                height: height,
                color: Style.controlPanelColor,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.arrow_left),
                    onPressed: gameLogic.openControlPanel,
                  ),
                ),
              );
            }

            //Todo: this logic should be somewhere else, like "shelter state"?

            if (snapshot.data is ControlPanelShown) {
              width = MediaQuery.of(context).size.width * .8;
              return Container(
                height: height,
                width: width,
                color: Style.controlPanelColor,
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.computer),
                          onPressed: gameLogic.rotateGamePanelState,
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_right),
                          onPressed: gameLogic.closeControlPanel,
                        ),
                        Container(),
                      ],
                    ),
                    Expanded(
                      child: StreamBuilder<ShelterState>(
                          stream: gameLogic.shelterState,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Container();

                            List<Widget> buttonsToShow = <Widget>[];

                            buttonsToShow.add(
                              GameButton(
                                  text: 'Rescue Dog',
                                  onPressed: gameLogic.rescueDog),
                            );

                            buttonsToShow.add(
                              GameButton(
                                  text: 'Feed Dog',
                                  onPressed: gameLogic.feedAndPetDog),
                            );
                            if (snapshot.data.shelter.dogs >= 10)
                              buttonsToShow.add(
                                GameButton(
                                    text: 'Hire Volunteer',
                                    onPressed: gameLogic.hireVolunteer),
                              );
                            if (snapshot.data.shelter.volunteers > 0)
                              buttonsToShow.add(
                                GameButton(
                                  text: 'Praise Volunteer',
                                  onPressed: gameLogic.praiseVolunteer,
                                ),
                              );
                            if (snapshot.data.shelter.volunteers >= 10)
                              buttonsToShow.add(
                                GameButton(
                                    text: 'Hire Employee',
                                    onPressed: gameLogic.hireEmployee),
                              );

                            return ListView(
                              children: buttonsToShow,
                            );
                          }),
                    ),
                    Container()
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              );
            }
          }),
    );
  }
}
