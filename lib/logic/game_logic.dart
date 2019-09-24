import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shelter_manager/logic/base_logic.dart';
import 'package:shelter_manager/res/models/shelter.dart';

// This class handles the game logic, processing player inputs and calculating
// the current game state

class GameLogic implements BaseLogic {
  // Control panel controls
  StreamController<ControlPanelState> _controlPanelStateController =
      StreamController<ControlPanelState>();
  Stream<ControlPanelState> get controlPanelState =>
      _controlPanelStateController.stream;

  void openControlPanel() =>
      _controlPanelStateController.sink.add(ControlPanelShown());
  void closeControlPanel() =>
      _controlPanelStateController.sink.add(ControlPanelHidden());

  Function get feedDog => _theShelter.feedDog;
  Function get feedAndPetDog => _theShelter.feedAndPetDog;
  Function get rescueDog => _theShelter.addDog;
  Function get hireVolunteer => _theShelter.hireVolunteer;
  Function get praiseVolunteer => _theShelter.praiseVolunteer;
  Function get hireEmployee => _theShelter.hireEmployee;

  // Shelter state stream
  BehaviorSubject<ShelterState> _shelterStateStream =
      BehaviorSubject<ShelterState>();
  Stream<ShelterState> get shelterState => _shelterStateStream.stream;

  void _updateShelter() =>
      _shelterStateStream.sink.add(ShelterState(shelter: _theShelter));

  // This game session's shelter instance
  Shelter _theShelter = Shelter();

  //the timer that fires the game loop
  Timer _gameLoopTimer;

  //what information to show on the game screen
  GamePanelState gamePanelState = GamePanelState.showGeneralInfo;

  //initialize the streams when an instance is created
  GameLogic() {
    openControlPanel();

    _startGameTimer();
  }

  void _startGameTimer() {
    //the game loop runs 10x per second, which is arbitrary but fast enough hopefully to seem continuous
    _gameLoopTimer = Timer.periodic(Duration(milliseconds: 100), _gameLoop);
  }

  void _gameLoop(Timer timer) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    _theShelter.runLoop(currentTime);

    _updateShelter();
  }

  void rotateGamePanelState() {
    switch (gamePanelState) {
      case GamePanelState.showDogs:
        gamePanelState = GamePanelState.showVolunteers;
        break;
      case GamePanelState.showVolunteers:
        gamePanelState = GamePanelState.showEmployees;
        break;
      case GamePanelState.showEmployees:
        gamePanelState = GamePanelState.showGeneralInfo;
        break;
      case GamePanelState.showGeneralInfo:
        gamePanelState = GamePanelState.showDogs;
        break;
    }
  }

  @override
  void dispose() {
    _controlPanelStateController.close();
    _shelterStateStream.close();
    _gameLoopTimer.cancel();
  }
}

enum GamePanelState { showDogs, showVolunteers, showEmployees, showGeneralInfo }

class ControlPanelState {}

class ControlPanelShown extends ControlPanelState {}

class ControlPanelHidden extends ControlPanelState {}
