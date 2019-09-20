import 'package:flutter/material.dart';
import 'package:shelter_manager/logic/base_logic.dart';
import 'package:shelter_manager/logic/game_logic.dart';

class GameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameLogic gameLogic = LogicProvider.of<GameLogic>(context);

    return StreamBuilder<Shelter>(
      stream: gameLogic.shelterState,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("${snapshot.data.dogs} dogs"),
              Text("${snapshot.data.dogs - snapshot.data.dogsFed} hungry"),
            ],
          ),
        );
      },
    );
  }
}
