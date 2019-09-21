
class Dog {

  bool hungry;
  int lastFed;
  double healthPct;
  int getsHungryAfter = 5000;

  bool unhappy;
  int lastPet;
  double happinessPct;
  int getsUnhappyAfter = 2000;

  Dog(){
    feed();
    healthPct = 1.0;

    pet();
    happinessPct = 1.0;

  }

  void feed(){
    hungry = false;
    lastFed = DateTime.now().millisecondsSinceEpoch;
  }

  void pet(){
    unhappy = false;
    lastPet = DateTime.now().millisecondsSinceEpoch;
  }

  void runLoop(int currentTime){
    if(currentTime - lastFed > getsHungryAfter) hungry = true;
    
    if(hungry){
      if(healthPct > 0.0) healthPct -= .002;
    }
    else if(healthPct < 1.0){
      healthPct += .005;
    }
    
    if(currentTime - lastPet > getsUnhappyAfter) unhappy = true;
    
    if(unhappy){
      if(happinessPct > 0.0) happinessPct -= .002;
    }
    else if(happinessPct < 1.0){
      happinessPct += .002;
    }

  }

}