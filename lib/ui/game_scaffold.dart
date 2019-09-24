import 'package:flutter/material.dart';
import 'package:shelter_manager/logic/base_logic.dart';
import 'package:shelter_manager/logic/game_logic.dart';
import 'package:shelter_manager/logic/scaffold_logic.dart';
import 'package:shelter_manager/ui/control_panel.dart';
import 'package:shelter_manager/ui/game_view.dart';

class GameScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScaffoldLogic loadingStateLogic = ScaffoldLogic();

    return Scaffold(

      // the logic provider class provides access to the particular instance of the logic element
      // to any descendent on the widget tree. It also disposes of resources when the widget is disposed.
      body: LogicProvider(
          bloc: loadingStateLogic,

          // the streambuilder connects a stream to a builder method. It listens to a particular stream 
          // in the logic class and automatically re-runs the builder method to update the child element
          // any time new data appears in the stream, accessed by snapshot.data
          child: StreamBuilder<GameState>(
            stream: loadingStateLogic.gameState,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              if (snapshot.data is GameStatePlaying) {
                return PlayingScreen();
              }
              if (snapshot.data is GameStateLoading) {
                return LoadingScreen();
              }
            },
          )),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('loading ...'),
          Container(height: 30.0),
          CircularProgressIndicator(
            strokeWidth: 1.0,
          ),
        ],
      ),
    );
  }
}

class PlayingScreen extends StatelessWidget {
  GameLogic _gameLogic = GameLogic();

  @override
  Widget build(BuildContext context) {
    return LogicProvider(
      bloc: _gameLogic,
      child: Stack(
        children: [
          GameView(),
          
          ControlPanel(),
        ],
      ),
    );
  }
}
