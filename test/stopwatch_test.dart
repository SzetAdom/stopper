import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/model/my_stopwatch_model.dart';
import 'package:stopwatch/page/stopwatch_page.dart';

void main() {
  ///Unit tests
  test('MyStopwatch does not start on default', () async {
    MyStopwatchModel myStopwatchModel = MyStopwatchModel();

    expect(myStopwatchModel.formatTime(), '00:00.000');
    expect(myStopwatchModel.stopwatch.isRunning, false);
  });

  test(
      'MyStopwatch starts and elapsedTime increments when startStopwatch is called',
      () async {
    MyStopwatchModel myStopwatchModel = MyStopwatchModel();

    var initialElapsedTime = myStopwatchModel.elapsedTime;

    myStopwatchModel.startStopwatch();
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    expect(myStopwatchModel.stopwatch.isRunning, true);
    expect(myStopwatchModel.elapsedTime, greaterThan(initialElapsedTime));
  });

  test('MyStopwatch stops when stopStopwatch is called', () async {
    MyStopwatchModel myStopwatchModel = MyStopwatchModel();

    myStopwatchModel.startStopwatch();
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    myStopwatchModel.stopStopwatch();
    var elapsedTime = myStopwatchModel.elapsedTime;
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    expect(myStopwatchModel.stopwatch.isRunning, false);
    expect(myStopwatchModel.elapsedTime, elapsedTime);
  });

  test('MyStopwatch resets when resetStopwatch is called', () async {
    MyStopwatchModel myStopwatchModel = MyStopwatchModel();

    myStopwatchModel.startStopwatch();
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    myStopwatchModel.resetStopwatch();
    expect(myStopwatchModel.stopwatch.isRunning, false);
    expect(myStopwatchModel.elapsedTime, Duration.zero);
  });

  ///Widget tests

  String? findElapsedTime() {
    var textFind = find.byKey(const Key('elapsedTime'));
    expect(textFind, findsOneWidget);
    return (textFind.evaluate().first.widget as Text).data;
  }

  testWidgets('On stopwatchPage button clicks ui changes correctly',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: StopwatchPage(),
    ));

    findElapsedTime();

    expect(findElapsedTime(), equals('00:00.000'));

    await widgetTester.tap(find.byKey(const Key('startButton')));
    await widgetTester.pump(const Duration(milliseconds: 1000));

    expect(findElapsedTime(), isNot(equals('00:00.000')));

    var initialElapsedTime = findElapsedTime();

    await widgetTester.tap(find.byKey(const Key('pauseButton')));
    await widgetTester.pump();

    expect(findElapsedTime(), equals(initialElapsedTime));

    await widgetTester.tap(find.byKey(const Key('resetButton')));
    await widgetTester.pump();

    expect(findElapsedTime(), equals('00:00.000'));
  });

  testWidgets('Edge cases', (widgetTester) async {
    MaterialApp app = const MaterialApp(
      home: StopwatchPage(),
    );
    await widgetTester.pumpWidget(app);

    ///Doesn't crash when buttons are pressed before start
    await widgetTester.tap(find.byKey(const Key('pauseButton')));
    expect(findElapsedTime(), equals('00:00.000'));

    await widgetTester.tap(find.byKey(const Key('resetButton')));
    expect(findElapsedTime(), equals('00:00.000'));

    ///Doesn't crash when buttons are pressed after stop and reset
    await widgetTester.tap(find.byKey(const Key('startButton')));
    await widgetTester.pump(const Duration(milliseconds: 1000));

    ///Doesn't behave unexpectedly when start is pressed while stopwatch is running
    var initialElapsedTime = findElapsedTime();
    await widgetTester.tap(find.byKey(const Key('startButton')));
    expect(findElapsedTime(), equals(initialElapsedTime));

    ///Doesn't behave unexpectedly when stop is pressed while stopwatch is stopped
    await widgetTester.tap(find.byKey(const Key('pauseButton')));
    expect(findElapsedTime(), equals(initialElapsedTime));

    await widgetTester.tap(find.byKey(const Key('pauseButton')));
    expect(findElapsedTime(), equals(initialElapsedTime));

    ///Doesn't behave unexpectedly when reset is pressed while stopwatch is reset
    await widgetTester.tap(find.byKey(const Key('resetButton')));
    await widgetTester.pump(const Duration(milliseconds: 100));
    expect(findElapsedTime(), equals('00:00.000'));

    await widgetTester.tap(find.byKey(const Key('resetButton')));
    await widgetTester.pump(const Duration(milliseconds: 100));
    expect(findElapsedTime(), equals('00:00.000'));
  });
}
