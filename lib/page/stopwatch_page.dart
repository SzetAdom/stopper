import 'package:flutter/material.dart';
import 'package:stopwatch/model/my_stopwatch_model.dart';
import 'package:stopwatch/widget/analalog_clock_widget.dart';
import 'package:stopwatch/widget/lap_widget.dart';
import 'package:stopwatch/widget/stopwatch_widget.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late MyStopwatchModel _stopwatchModel;

  @override
  void initState() {
    super.initState();
    _stopwatchModel = MyStopwatchModel();
  }

  double clocksSize(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return shortestSide * 0.4;
    }
    return shortestSide / 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text("Stopwatch",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: AnalogClockWidget(
                  _stopwatchModel,
                  size: clocksSize(context),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: StopWatchWidget(_stopwatchModel),
            ),
            Expanded(
              flex: 3,
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: LapWidget(_stopwatchModel)),
            ),
          ],
        ),
      ),
    );
  }
}
