import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Notify listeners about the change
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  void setValue(int value) {
    _count = value;
    notifyListeners();
  }
}


class InitialDurationProvider extends ChangeNotifier {
  int _initialDuration = 0;
  bool _handleStartStop = false;
  String _countdownupdate = '';

  int get initialDuration => _initialDuration;

  void setInitialDuration(int duration) {
    _initialDuration = duration;
    print(_initialDuration);
    notifyListeners();
  }

  bool get handleStartStop => _handleStartStop;

  void setstartstop(bool thestartstop){
    _handleStartStop = thestartstop;
    
    notifyListeners();
  }

  String get countdownupdate => countdownupdate;

  void setCountdownupdate(String thecountdownstring){
    _countdownupdate = thecountdownstring;
    // print(_countdownupdate);
  }
}