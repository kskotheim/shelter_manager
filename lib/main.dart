import 'package:flutter/material.dart';
import 'package:shelter_manager/ui/game_scaffold.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelter Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScaffold(),
    );
  }
}
