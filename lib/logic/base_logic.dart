import 'package:flutter/material.dart';

abstract class BaseLogic {
  void dispose();
}

// The LogicProvider class provides access to a logic class to branches of the 
// widget tree. It also is a stateful widget, which has lifecycle overrides, 
// so it calls dispose() on the logic elements' resources to avoid memory issues

class LogicProvider<T extends BaseLogic> extends StatefulWidget {
  LogicProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BaseLogic>(BuildContext context) {
    final type = _typeOf<LogicProvider<T>>();
    LogicProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<LogicProvider<BaseLogic>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
