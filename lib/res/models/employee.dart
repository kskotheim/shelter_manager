import 'package:shelter_manager/res/models/shelter.dart';

class Employee {
  
  final Shelter shelter;

  int praiseVolunteerTime = 2000;
  int lastPraised = DateTime.now().millisecondsSinceEpoch;


  Employee({this.shelter}) : assert(shelter != null);

  void runLoop(int currentTime){
    if(currentTime - lastPraised > praiseVolunteerTime){
      shelter.praiseVolunteer();
      lastPraised = currentTime;
    }
  }
}