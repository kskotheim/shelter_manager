import 'dart:math';

import 'package:shelter_manager/res/models/shelter.dart';

class Employee {
  final Shelter shelter;

  double stabilityPct = 1.0;
  bool stable = true;
  int timeUntilVacationNeeded = 15000;
  int vacationTaken = DateTime.now().millisecondsSinceEpoch;

  int praiseVolunteerTime = 2000;
  int lastPraised = DateTime.now().millisecondsSinceEpoch;

  Employee({this.shelter}) : assert(shelter != null);

  void runLoop(int currentTime) {
    if (currentTime - lastPraised > praiseVolunteerTime) {
      if (Random().nextDouble() < stabilityPct) {
        shelter.praiseVolunteer();
      }
      lastPraised = currentTime;
    }
    if(currentTime - vacationTaken > timeUntilVacationNeeded){
      stable = false;
    }
    if(stable){
      if(stabilityPct < 1.0) stabilityPct += .005;
    }
    else {
      if(stabilityPct > 0.0) stabilityPct -= .005;
    }

  }
}
