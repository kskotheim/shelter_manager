
import 'package:shelter_manager/res/models/shelter.dart';

class Volunteer {

  bool happy = true;
  int lastPraised = DateTime.now().millisecondsSinceEpoch;
  int requiresPraiseAfter = 10000;
  double happinessPct = 1.0;

  final Shelter shelter;

  int feedingSpeed = 500;
  int lastFed = DateTime.now().millisecondsSinceEpoch;

  Volunteer({this.shelter}) : assert(shelter != null);

  void runLoop(int currentTime){
    if(currentTime - lastFed > feedingSpeed){
      if(happy) shelter.feedAndPetDog();
      else shelter.feedDog();
      
      lastFed = currentTime;
    }
    if(currentTime - lastPraised > requiresPraiseAfter){
      happy = false;
    }

    if(happy){
      if(happinessPct < 1.0) happinessPct += .005;      
    } else {
      if(happinessPct > 0) happinessPct -= .005;
    }
  }

  void praise(){
    happy = true;
    lastPraised = DateTime.now().millisecondsSinceEpoch;
  }


}