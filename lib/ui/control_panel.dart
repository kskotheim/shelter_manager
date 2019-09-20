import 'package:flutter/material.dart';
import 'package:shelter_manager/logic/base_logic.dart';
import 'package:shelter_manager/logic/game_logic.dart';
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
            if (snapshot.data is ControlPanelShown) {
              width = MediaQuery.of(context).size.width * .8;
              return Container(
                height: height,
                width: width,
                color: Style.controlPanelColor,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      onPressed: gameLogic.closeControlPanel,
                    ),
                    RescueDogButton(),
                    FeedDogButton(),
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

class RescueDogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameLogic gameLogic = LogicProvider.of<GameLogic>(context);

    return RaisedButton(
      child: Text('Rescue Dog'),
      onPressed: gameLogic.rescueDog,
    );
  }
}

class FeedDogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameLogic gameLogic = LogicProvider.of<GameLogic>(context);

    return RaisedButton(
      child: Text('Feed Dog'),
      onPressed: gameLogic.feedDog,
    );
  }
}
