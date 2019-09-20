import 'dart:async';
import 'package:shelter_manager/logic/base_logic.dart';

// This class handles the game logic, processing player inputs and calculating
// the current game state

class GameLogic implements BaseLogic {

  // Control panel controls
  StreamController<ControlPanelState> _controlPanelStateController = StreamController<ControlPanelState>();
  Stream<ControlPanelState> get controlPanelState => _controlPanelStateController.stream;

  void openControlPanel() => _controlPanelStateController.sink.add(ControlPanelShown());
  void closeControlPanel() => _controlPanelStateController.sink.add(ControlPanelHidden());

  // Shelter event stream
  StreamController<ShelterEvent> _shelterEventController = StreamController<ShelterEvent>();

  void feedDog() => _shelterEventController.sink.add(FeedDogEvent());
  void rescueDog() => _shelterEventController.sink.add(AddDogEvent());

  // Shelter state stream
  StreamController<Shelter> _shelterStateStream = StreamController<Shelter>();
  Stream<Shelter> get shelterState => _shelterStateStream.stream;

  void _updateShelter() => _shelterStateStream.sink.add(_theShelter);

  // This game session's shelter instance
  Shelter _theShelter = Shelter();
  
  //this timer triggers dog hunger
  Timer _hungryDogsTimer;

  //initialize the streams when an instance is created
  GameLogic(){
    openControlPanel();
    _shelterEventController.stream.listen(_mapShelterEventToGameState);
    _startHungerTimer();
  }

  void _mapShelterEventToGameState(ShelterEvent event){

    if(event is AddDogEvent){
      _theShelter.addDog();
      _updateShelter();
    }

    if(event is FeedDogEvent){
      _theShelter.feedDog();
      _updateShelter();
    }
  }

  void _startHungerTimer(){
    _hungryDogsTimer = Timer.periodic(Duration(seconds: 5), _resetDogHunger);
  }

  void _resetDogHunger(Timer timer){
    _theShelter.dogsHungry();
    _updateShelter();
  }

  @override
  void dispose() {
    _controlPanelStateController.close();
    _shelterEventController.close();
    _shelterStateStream.close();
    _hungryDogsTimer.cancel();
  }  
}


class ControlPanelState {}
class ControlPanelShown extends ControlPanelState{}
class ControlPanelHidden extends ControlPanelState{}

class ShelterEvent {}
class AddDogEvent extends ShelterEvent{}
class FeedDogEvent extends ShelterEvent{}


// Model for the shelter that is the current game session
class Shelter {
  int dogs;
  int dogsFed;

  Shelter({this.dogs}){
    if(dogs == null) dogs = 0;
    dogsFed = 0;
  }

  void addDog(){
    dogs ++;
  }
  void feedDog(){
    dogsFed ++;
    if(dogsFed > dogs) dogsFed = dogs;
  }
  void dogsHungry(){
    dogsFed = 0;
  }
  
  String getDogCount(){
    return "$dogs dogs, ${dogs - dogsFed} hungry";
  }

}