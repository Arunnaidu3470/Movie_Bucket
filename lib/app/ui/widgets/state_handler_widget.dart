import 'package:flutter/material.dart';

/// Statehandlers states
enum StatehandlerStates {
  initialState,
  loadingState,
  loadedState,
  errorState,
}

/// To use StateHandlerWidget you must override
/// this abstract class's state variable
abstract class StateHandlerWidgetState {
  StatehandlerStates state;
}

/// This widget renders your widgets based on your state
///
/// Avaliable states:
///
/// - `initialState`: StatehandlerStates.initialState
/// - `loadingState`: StatehandlerStates.loadingState
/// - `loadedState`: StatehandlerStates.loadedState
/// - `errorState` : StatehandlerStates.errorState
/// - `invalidState`: StatehandlerStates.invalidState
///
class StateHandlerWidget extends StatelessWidget {
  final StateHandlerWidgetState currentState;
  final Widget Function(BuildContext context) initialState;
  final Widget Function(BuildContext context) loadingState;
  final Widget Function(BuildContext context) loadedState;
  final Widget Function(BuildContext context) errorState;
  final Widget Function(BuildContext context) invalidState;

  const StateHandlerWidget({
    Key key,
    @required this.currentState,
    @required this.initialState,
    @required this.loadingState,
    @required this.loadedState,
    @required this.errorState,
    @required this.invalidState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (currentState.state) {
      case StatehandlerStates.initialState:
        return initialState(context);
      case StatehandlerStates.loadingState:
        return loadingState(context);
      case StatehandlerStates.loadedState:
        return loadedState(context);
      case StatehandlerStates.loadingState:
        return loadedState(context);
      case StatehandlerStates.errorState:
        return errorState(context);
      default:
        return invalidState(context);
    }
  }
}
