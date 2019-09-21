import 'package:flutter/material.dart';
import 'package:shelter_manager/logic/base_logic.dart';
import 'package:shelter_manager/logic/game_logic.dart';
import 'package:shelter_manager/res/models/shelter.dart';

class GameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameLogic gameLogic = LogicProvider.of<GameLogic>(context);

    return StreamBuilder<Shelter>(
      stream: gameLogic.shelterState,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("${snapshot.data.dogs} dogs"),
                  snapshot.data.dogs > 0 ? Text("${snapshot.data.dogs - snapshot.data.dogsFed} hungry") : Container(),
                  snapshot.data.dogs > 0 ? Text("${snapshot.data.dogsHappy} happy") : Container(),
                  snapshot.data.dogs > 0 ? Text("${snapshot.data.volunteers} volunteers") : Container(),
                  snapshot.data.volunteers > 0 ? Text("${snapshot.data.happyVolunteers} happy") : Container(),
                  snapshot.data.volunteers > 0 ? Text("${snapshot.data.employees} employees") : Container(), 
                  Text("${snapshot.data.dollars} dollars"),

                ],
              ),
            ),

            //check overlay flag to see whether to display dog info
            gameLogic.gameOverlay == GameOverlay.overlayDogs
            ? GridView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: Color.fromRGBO(20, 20, 20, .2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            "Health: ${(snapshot.data.dogHealthList[index]*100).round()}%"),
                        Text("Happy: ${(snapshot.data.dogHappinessList[index]*100).round()}%"),
                      ],
                    ),
                  ),
                );
              },
              itemCount: snapshot.data.dogs,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * .25),
            )
            : Container(),
          ],
        );
      },
    );
  }
}
