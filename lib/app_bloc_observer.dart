import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) => super.onCreate(bloc);

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    Log.i(
      '${bloc.runtimeType} $event',
      time: DateTime.now(),
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Log.w(
      '${bloc.runtimeType} $change',
      time: DateTime.now(),
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Log.w(
      '${bloc.runtimeType} $transition',
      time: DateTime.now(),
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Log.e(
      '${bloc.runtimeType} $error $stackTrace',
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) => super.onClose(bloc);
}
