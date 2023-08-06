import 'dart:async';

import 'package:flutter/material.dart';

class MyStopwatchModel with ChangeNotifier {
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  List<Duration> laps = [];

  Duration get elapsedTime => stopwatch.elapsed;

  bool get isStarted => elapsedTime != Duration.zero;

  String formatTime({Duration? time}) {
    time ??= elapsedTime;

    final minutes = (time.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (time.inSeconds % 60).toString().padLeft(2, '0');
    final milliseconds =
        (time.inMilliseconds % 1000).toString().padLeft(3, '0');

    return '$minutes:$seconds.$milliseconds';
  }

  String? getLapTime(int index) {
    if (index >= laps.length || index < 0) return null;

    return formatTime(time: laps[laps.length - 1 - index]);
  }

  void startStopwatch() {
    if (stopwatch.isRunning) return;
    stopwatch.start();
    timer = Timer.periodic(const Duration(milliseconds: 1), updateTime);
  }

  void stopStopwatch() {
    stopwatch.stop();
    timer?.cancel();
  }

  void resetStopwatch() {
    stopwatch.stop();
    stopwatch.reset();
    timer?.cancel();
    updateTime(null);
  }

  void pauseStopwatch() {
    if (stopwatch.elapsed == Duration.zero) return;
    stopwatch.isRunning ? stopwatch.stop() : stopwatch.start();
  }

  void updateTime(Timer? timer) {
    notifyListeners();
  }

  void addLap() {
    laps.add(stopwatch.elapsed);
  }

  void clearLaps() {
    laps.clear();
  }
}
