import 'package:flutter/material.dart';

class Style {

  static final Color controlPanelColor = Colors.blue;





}

class GameButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  GameButton({this.onPressed, this.text})
      : assert(onPressed != null, text != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text(text),
        onPressed: onPressed,
      ),
    );
  }
}