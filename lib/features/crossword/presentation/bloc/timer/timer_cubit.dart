import 'dart:async';

import 'package:bloc/bloc.dart';

class TimerCubit extends Cubit<int> {
  late final Timer _timer;
  int _secondsElapsed = 0;
  TimerCubit() : super(0) {
    _createTimer();
  }

  _createTimer() {
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        _secondsElapsed++;
        emit(_secondsElapsed);
      },
    );
  }

  void finish() {
    _timer.cancel();
  }

  int get getSecondsElapsed => _secondsElapsed;

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
