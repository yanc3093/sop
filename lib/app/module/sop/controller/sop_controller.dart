import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

class SopController {
  final _stopwatchController = BehaviorSubject<Duration>();
  final _lastSopController = BehaviorSubject<int>();
  final _stopwatchButtonController = BehaviorSubject<ButtonState>();
  final _nextItemButtonController = BehaviorSubject<bool>();
  final _itemIndicatorController = BehaviorSubject<List>();
  final Stopwatch _stopwatch = Stopwatch();
  final int _lastSopOfTask = 6;
  int _currentItemIndex = 0;
  int _elapsedTimeInSeconds = 0;
  final int _numberOfItemsRequired = 5;
  int _numberOfItemsCompleted = 0;
  DateTime _startDatetime = DateTime.now();
  DateTime _endDatetime = DateTime.now();

  Future<void> init() async {
    _stopwatchController.sink.add(const Duration(seconds: 0));
    _lastSopController.sink.add(1);
    _elapsedTimeInSeconds = 0;
    _stopwatchButtonController.sink.add(ButtonState.start);
    if (_currentItemIndex == _numberOfItemsCompleted - 1) {
      _nextItemButtonController.sink.add(true);
    } else {
      _nextItemButtonController.sink.add(false);
    }
    List itemIndicator = [];
    for (var i = 0; i < _numberOfItemsRequired; i++) {
      itemIndicator.add({
        'value': '${i + 1}',
        'selected': _currentItemIndex == i,
        'completed': i + 1 <= _numberOfItemsCompleted,
      });
    }
    int startIndex = 0;
    int endIndex = _numberOfItemsRequired;
    if (_currentItemIndex == 0) {
      endIndex = min(_currentItemIndex + 5, _numberOfItemsRequired);
    } else if (_currentItemIndex == 1) {
      endIndex = min(_currentItemIndex + 4, _numberOfItemsRequired);
    } else {
      endIndex = min(_currentItemIndex + 3, _numberOfItemsRequired);
    }
    if (_currentItemIndex == _numberOfItemsRequired - 1) {
      startIndex = max(_currentItemIndex - 4, 0);
    } else if (_currentItemIndex == _numberOfItemsRequired - 2) {
      startIndex = max(_currentItemIndex - 3, 0);
    } else {
      startIndex = max(_currentItemIndex - 2, 0);
    }
    List fiveItemIndicator = itemIndicator.sublist(startIndex, endIndex);
    if (int.parse(fiveItemIndicator[0]['value']) == 2) {
      fiveItemIndicator.insert(0, {
        'value': '1',
        'selected': false,
        'completed': 1 <= _numberOfItemsCompleted,
      });
    } else if (int.parse(fiveItemIndicator[0]['value']) > 2) {
      fiveItemIndicator.insert(0, {
        'value': '...',
        'selected': false,
        'completed': false,
      });
      fiveItemIndicator.insert(0, {
        'value': '1',
        'selected': false,
        'completed': 1 <= _numberOfItemsCompleted,
      });
    }
    if (int.parse(fiveItemIndicator[fiveItemIndicator.length - 1]['value']) ==
        _numberOfItemsRequired - 1) {
      fiveItemIndicator.add({
        'value': '$_numberOfItemsRequired',
        'selected': false,
        'completed': _numberOfItemsRequired <= _numberOfItemsCompleted,
      });
    } else if (int.parse(
          fiveItemIndicator[fiveItemIndicator.length - 1]['value'],
        ) <
        _numberOfItemsRequired - 1) {
      fiveItemIndicator.add({
        'value': '...',
        'selected': false,
        'completed': false,
      });
      fiveItemIndicator.add({
        'value': '$_numberOfItemsRequired',
        'selected': false,
        'completed': _numberOfItemsRequired <= _numberOfItemsCompleted,
      });
    }
    _itemIndicatorController.sink.add(fiveItemIndicator);
  }

  Future<void> startStopwatch() async {
    _startDatetime = DateTime.now();
    _stopwatch.start();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_stopwatch.isRunning) {
        timer.cancel();
      } else {
        _stopwatchController.sink.add(
          Duration(
            seconds:
                _elapsedTimeInSeconds +
                (_stopwatch.elapsedMilliseconds * 0.001).round(),
          ),
        );
      }
    });
    _stopwatchButtonController.sink.add(ButtonState.pause);
  }

  Future<void> stopStopwatch(bool sopIsDone, bool itemIsDone) async {
    _stopwatch.stop();
    _stopwatch.reset();
    _endDatetime = DateTime.now();
    Duration duration = _endDatetime.difference(_startDatetime);
    _elapsedTimeInSeconds += duration.inSeconds;
    _stopwatchController.sink.add(Duration(seconds: _elapsedTimeInSeconds));
    _stopwatchButtonController.sink.add(
      itemIsDone ? ButtonState.done : ButtonState.resume,
    );
  }

  Future<bool> nextSop() async {
    bool completeItem = false;
    if (_lastSopController.value == _lastSopOfTask) {
      await stopStopwatch(true, true);
      _numberOfItemsCompleted += 1;
      completeItem = true;
      _nextItemButtonController.sink.add(true);
    } else {
      await stopStopwatch(true, false);
      await startStopwatch();
    }
    _lastSopController.sink.add(_lastSopController.value + 1);
    return completeItem;
  }

  Future<void> nextItem() async {
    _resetVariables();
    _currentItemIndex += 1;
    _nextItemButtonController.sink.add(false);
    _stopwatchController.sink.add(const Duration(seconds: 0));
    _lastSopController.sink.add(1);
    _elapsedTimeInSeconds = 0;
    _stopwatchButtonController.sink.add(ButtonState.start);
    List itemIndicator = [];
    for (var i = 0; i < _numberOfItemsRequired; i++) {
      itemIndicator.add({
        'value': '${i + 1}',
        'selected': _currentItemIndex == i,
        'completed': i + 1 <= _numberOfItemsCompleted,
      });
    }
    int startIndex = 0;
    int endIndex = _numberOfItemsRequired;
    if (_currentItemIndex == 0) {
      endIndex = min(_currentItemIndex + 5, _numberOfItemsRequired);
    } else if (_currentItemIndex == 1) {
      endIndex = min(_currentItemIndex + 4, _numberOfItemsRequired);
    } else {
      endIndex = min(_currentItemIndex + 3, _numberOfItemsRequired);
    }
    if (_currentItemIndex == _numberOfItemsRequired - 1) {
      startIndex = max(_currentItemIndex - 4, 0);
    } else if (_currentItemIndex == _numberOfItemsRequired - 2) {
      startIndex = max(_currentItemIndex - 3, 0);
    } else {
      startIndex = max(_currentItemIndex - 2, 0);
    }
    List fiveItemIndicator = itemIndicator.sublist(startIndex, endIndex);
    if (int.parse(fiveItemIndicator[0]['value']) == 2) {
      fiveItemIndicator.insert(0, {
        'value': '1',
        'selected': false,
        'completed': 1 <= _numberOfItemsCompleted,
      });
    } else if (int.parse(fiveItemIndicator[0]['value']) > 2) {
      fiveItemIndicator.insert(0, {
        'value': '...',
        'selected': false,
        'completed': false,
      });
      fiveItemIndicator.insert(0, {
        'value': '1',
        'selected': false,
        'completed': 1 <= _numberOfItemsCompleted,
      });
    }
    if (int.parse(fiveItemIndicator[fiveItemIndicator.length - 1]['value']) ==
        _numberOfItemsRequired - 1) {
      fiveItemIndicator.add({
        'value': '$_numberOfItemsRequired',
        'selected': false,
        'completed': _numberOfItemsRequired <= _numberOfItemsCompleted,
      });
    } else if (int.parse(
          fiveItemIndicator[fiveItemIndicator.length - 1]['value'],
        ) <
        _numberOfItemsRequired - 1) {
      fiveItemIndicator.add({
        'value': '...',
        'selected': false,
        'completed': false,
      });
      fiveItemIndicator.add({
        'value': '$_numberOfItemsRequired',
        'selected': false,
        'completed': _numberOfItemsRequired <= _numberOfItemsCompleted,
      });
    }
    _itemIndicatorController.sink.add(fiveItemIndicator);
  }

  void _resetVariables() {
    _stopwatch.reset();
  }

  Stream<Duration> get stopwatchStream => _stopwatchController.stream;

  Stream<int> get lastSopStream => _lastSopController.stream;

  Stream<ButtonState> get stopwatchButtonStream =>
      _stopwatchButtonController.stream;

  Stream<bool> get nextItemButtonStream => _nextItemButtonController.stream;

  Stream<List> get itemIndicatorStream => _itemIndicatorController.stream;
}

enum ButtonState { start, resume, pause, stop, done }
