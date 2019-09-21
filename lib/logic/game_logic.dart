import 'dart:async';
import 'package:shelter_manager/logic/base_logic.dart';
import 'package:shelter_manager/res/models/shelter.dart';

// This class handles the game logic, processing player inputs and calculating
// the current game state

class GameLogic implements BaseLogic {

  // Control panel controls
  StreamController<ControlPanelState> _controlPanelStateController = StreamController<ControlPanelState>();
  Stream<ControlPanelState> get controlPanelState => _controlPanelStateController.stream;

  void openControlPanel() => _controlPanelStateController.sink.add(ControlPanelShown());
  void closeControlPanel() => _controlPanelStateController.sink.add(ControlPanelHidden());

  Function get feedDog => _theShelter.feedDog;
  Function get rescueDog => _theShelter.addDog;
  Function get hireVolunteer => _theShelter.hireVolunteer;
  Function get praiseVolunteer => _theShelter.praiseVolunteer;
  Function get hireEmployee => _theShelter.hireEmployee;

  // Shelter state stream
  StreamController<Shelter> _shelterStateStream = StreamController<Shelter>();
  Stream<Shelter> get shelterState => _shelterStateStream.stream;

  void _updateShelter() => _shelterStateStream.sink.add(_theShelter);

  // This game session's shelter instance
  Shelter _theShelter = Shelter();
  
  //the timer that fires the game loop
  Timer _gameLoopTimer;

  //what information to overlay on the game screen
  GameOverlay gameOverlay = GameOverlay.noOverlay;

  //initialize the streams when an instance is created
  GameLogic(){
    openControlPanel();
    
    _startGameTimer();
  }

  void _startGameTimer(){
    //the game loop runs 10x per second, which is arbitrary but fast enough hopefully to seem continuous
    _gameLoopTimer = Timer.periodic(Duration(milliseconds: 100), _gameLoop);
  }

  void _gameLoop(Timer timer){
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    _theShelter.runLoop(currentTime);

    _updateShelter();
  }

  @override
  void dispose() {
    _controlPanelStateController.close();
    _shelterStateStream.close();
    _gameLoopTimer.cancel();
  }  
}

enum GameOverlay{
  overlayDogs,
  overlayVolunteers,
  overlayEmployees,
  noOverlay
}


class ControlPanelState {}
class ControlPanelShown extends ControlPanelState{}
class ControlPanelHidden extends ControlPanelState{}
