import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterBlocObservable extends BlocObserver {
@override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- bloc: ${bloc.runtimeType}, event: $event' as num);
  }
@override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {

    super.onError(bloc, error, stackTrace);
    log('onEvent -- bloc: ${bloc.runtimeType}, error: $error' as num);
  }


}