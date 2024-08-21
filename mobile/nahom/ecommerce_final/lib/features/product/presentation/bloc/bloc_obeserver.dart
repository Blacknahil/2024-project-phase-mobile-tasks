import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    // debugPrint(transition as String?);
    print(
        '\n onTransition -- bloc: ${bloc.runtimeType}, transition: $transition \n');
  }

  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('\n onEvent -- bloc: ${bloc.runtimeType}, event: $event \n');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    // debugPrint(error.toString());
    super.onError(bloc, error, stackTrace);
    print('\n onError -- bloc: ${bloc.runtimeType}, error: $error\n');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('\n onChange -- bloc: ${bloc.runtimeType}, change: $change\n');
  }
}
