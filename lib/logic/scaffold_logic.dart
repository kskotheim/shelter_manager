import 'dart:async';
import 'package:shelter_manager/logic/base_logic.dart';

class ScaffoldLogic implements BaseLogic {

  // output stream
  StreamController<GameState> _gameController = StreamController<GameState>();
  Stream<GameState> get gameState => _gameController.stream;

  // an instance of this class is created when the game is started. 
  ScaffoldLogic(){
    _loadGame();
  }

  Future<void> _loadGame() async {
    _gameController.sink.add(GameStateLoading());
    
    await Future.delayed(Duration(seconds: 2));

    _gameController.sink.add(GameStatePlaying());
  }


  // called by the logic provider
  @override
  void dispose() {
    _gameController.close();
  }
}


// types which are processed by the gameState stream
class GameState{}
class GameStateLoading extends GameState {}
class GameStatePlaying extends GameState {}