import 'package:flutter/material.dart';
import 'package:stopwatch/model/my_stopwatch_model.dart';

class LapWidget extends StatelessWidget {
  const LapWidget(
    this.stopwatchModel, {
    super.key,
  });

  final MyStopwatchModel stopwatchModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: stopwatchModel,
        builder: (context, model) {
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      key: const Key('addLapButton'),
                      onPressed: stopwatchModel.isStarted
                          ? stopwatchModel.addLap
                          : null,
                      icon: const Icon(Icons.flag),
                      label: Text(
                        'Add lap',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      key: const Key('resetLapButton'),
                      onPressed: stopwatchModel.laps.isNotEmpty
                          ? stopwatchModel.clearLaps
                          : null,
                      icon: const Icon(Icons.refresh),
                      label: Text(
                        'Reset laps',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: stopwatchModel.laps.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        key: Key('lap$index'),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Lap ${stopwatchModel.laps.length - 1 - index}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                stopwatchModel.getLapTime(index) ?? '',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
