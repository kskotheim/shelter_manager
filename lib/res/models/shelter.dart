import 'package:shelter_manager/res/models/dog.dart';
import 'package:shelter_manager/res/models/employee.dart';
import 'package:shelter_manager/res/models/volunteer.dart';

class Shelter {

  //Dollars
  int _dollars = 0;
  
  int get dollars => _dollars;

  // Dogs
  List<Dog> _dogPile = <Dog>[];
  int _dogFeedingIndex = 0;

  int get dogs => _dogPile.length;
  int get dogsFed => _dogPile.map((Dog dog) => dog.hungry ? 0 : 1)?.reduce((a, b) => a + b);
  int get dogsHappy => _dogPile.map((Dog dog) => dog.unhappy ? 1 : 0)?.reduce((a, b) => a + b);
  List<double> get dogHealthList => _dogPile.map((dog) => dog.healthPct).toList();
  List<double> get dogHappinessList => _dogPile.map((dog) => dog.happinessPct).toList();

  // Volunteers
  List<Volunteer> _theVolunteers = <Volunteer>[];
  int _volunteerPraiseIndex = 0;

  int get volunteers => _theVolunteers.length;
  int get happyVolunteers => _theVolunteers.map((Volunteer volunteer) => volunteer.happy ? 1 : 0)?.reduce((a, b) => a + b);

  //Employees
  List<Employee> _theEmployees = <Employee>[];

  int get employees => _theEmployees.length;


  Shelter();


  void adjustDollars(int bling) => _dollars += bling;


  void addDog() => _dogPile.add(Dog());
  
  void feedDog(){
    if(_dogPile.isNotEmpty){
      _dogPile[_dogFeedingIndex].feed();
      _incrementFeedingIndex();
    }
  }

  void feedAndPetDog(){
     if(_dogPile.isNotEmpty){
      _dogPile[_dogFeedingIndex].feed();
      _dogPile[_dogFeedingIndex].pet();
      _incrementFeedingIndex();
    }
  }
  void _incrementFeedingIndex(){
    _dogFeedingIndex ++;
    if(_dogFeedingIndex >= _dogPile.length) _dogFeedingIndex = 0;
  }


  void hireVolunteer() => _theVolunteers.add(Volunteer(shelter: this));

  void praiseVolunteer(){
    if(_theVolunteers.isNotEmpty){
      _theVolunteers[_volunteerPraiseIndex].praise();
      _incrementPraiseIndex();
    }
  }


  void hireEmployee() => _theEmployees.add(Employee(shelter: this));

  void runLoop(int currentTime){
    _dogPile.forEach((Dog dog){
      dog.runLoop(currentTime);
    });
    
    _theVolunteers.forEach((Volunteer volunteer){
      volunteer.runLoop(currentTime);
    });

    _theEmployees.forEach((Employee employee){
      employee.runLoop(currentTime);
    });
  }
  
  void _incrementPraiseIndex(){
    _volunteerPraiseIndex ++;
    if(_volunteerPraiseIndex >= _theVolunteers.length) _volunteerPraiseIndex = 0;
  }
}
