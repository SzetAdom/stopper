import 'package:flutter/material.dart';
import 'package:stopwatch/model/my_stopwatch_model.dart';

class StopWatchWidget extends StatelessWidget {
  const StopWatchWidget(
    this.stopwatchModel, {
    super.key,
  });

  final MyStopwatchModel stopwatchModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: stopwatchModel,
        builder: (context, model) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    stopwatchModel.formatTime(),
                    style: Theme.of(context).textTheme.displayLarge,
                    key: const Key('elapsedTime'),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton.filled(
                      key: const Key('startButton'),
                      onPressed: !stopwatchModel.stopwatch.isRunning
                          ? stopwatchModel.startStopwatch
                          : null,
                      icon: const Icon(Icons.play_arrow),
                      disabledColor: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    IconButton.filled(
                      key: const Key('pauseButton'),
                      onPressed: stopwatchModel.isStarted
                          ? stopwatchModel.pauseStopwatch
                          : null,
                      icon: const Icon(Icons.pause),
                      disabledColor: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10),
                    IconButton.filled(
                        key: const Key('resetButton'),
                        onPressed: stopwatchModel.isStarted
                            ? stopwatchModel.resetStopwatch
                            : null,
                        icon: const Icon(Icons.refresh),
                        disabledColor: Theme.of(context).primaryColor),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
