import 'package:flutter/material.dart';
import 'package:shelter_manager/logic/base_logic.dart';
import 'package:shelter_manager/logic/game_logic.dart';
import 'package:shelter_manager/res/models/shelter.dart';

class GameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameLogic gameLogic = LogicProvider.of<GameLogic>(context);

    return StreamBuilder<ShelterState>(
      stream: gameLogic.shelterState,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        if (gameLogic.gamePanelState == GamePanelState.showGeneralInfo) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  snapshot.data.textToShow.map((text) => Text(text)).toList(),
            ),
          );
        }
        if (gameLogic.gamePanelState == GamePanelState.showDogs) {
          return buildDogGrid(snapshot, context);
        }
        if (gameLogic.gamePanelState == GamePanelState.showVolunteers){
          return buildVolunteerGrid(snapshot, context);
        }
        if (gameLogic.gamePanelState == GamePanelState.showEmployees){
          return buildEmployeeGrid(snapshot, context);
        }
      },
    );
  }

  GridView buildDogGrid(
      AsyncSnapshot<ShelterState> snapshot, BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            color: Color.fromRGBO(20, 20, 20, .2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "Health: ${(snapshot.data.shelter.dogHealthList[index] * 100).round()}%"),
                Text(
                    "Happy: ${(snapshot.data.shelter.dogHappinessList[index] * 100).round()}%"),
              ],
            ),
          ),
        );
      },
      itemCount: snapshot.data.shelter.dogs,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * .25),
    );
  }

  GridView buildVolunteerGrid(
      AsyncSnapshot<ShelterState> snapshot, BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            color: Color.fromRGBO(20, 20, 20, .2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "Happy: ${(snapshot.data.shelter.volunteerHappinessList[index] * 100).round()}%"),
              ],
            ),
          ),
        );
      },
      itemCount: snapshot.data.shelter.volunteers,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * .25),
    );
  }

  GridView buildEmployeeGrid(
      AsyncSnapshot<ShelterState> snapshot, BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            color: Color.fromRGBO(20, 20, 20, .2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "Stability: ${(snapshot.data.shelter.employeeStabilityList[index] * 100).round()}%"),
              ],
            ),
          ),
        );
      },
      itemCount: snapshot.data.shelter.employees,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * .25),
    );
  }
}
