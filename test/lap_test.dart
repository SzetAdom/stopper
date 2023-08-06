import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/model/my_stopwatch_model.dart';

void main() {
  test('Can add new lap', () async {
    MyStopwatchModel myStopwatchModel = MyStopwatchModel();

    myStopwatchModel.startStopwatch();
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    myStopwatchModel.addLap();
    expect(myStopwatchModel.stopwatch.elapsed - myStopwatchModel.laps[0],
        lessThan(const Duration(milliseconds: 100)));
  });

  test('Can reset laps', () async {
    MyStopwatchModel myStopwatchModel = MyStopwatchModel();

    myStopwatchModel.startStopwatch();
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    myStopwatchModel.addLap();
    expect(myStopwatchModel.laps.length, 1);
    myStopwatchModel.clearLaps();
    expect(myStopwatchModel.laps.length, 0);
  });
}
