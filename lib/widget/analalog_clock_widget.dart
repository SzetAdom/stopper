import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stopwatch/model/my_stopwatch_model.dart';

class AnalogClockWidget extends StatelessWidget {
  const AnalogClockWidget(this.stopwatchModel, {this.size = 160, super.key});

  final MyStopwatchModel stopwatchModel;
  final double size;

  final double dotPadding = 0.25;

  Offset dotOffset(int i) {
    return Offset(
      (size / 2) * (1 - dotPadding) * cos(pi / 30 * (i - 15)),
      (size / 2) * (1 - dotPadding) * sin(pi / 30 * (i - 15)),
    );
  }

  final double numberPadding = 0.1;

  Offset numberOffset(int i) {
    return Offset(
      (size / 2) * (1 - numberPadding) * cos(pi / 6 * (i - 2)),
      (size / 2) * (1 - numberPadding) * sin(pi / 6 * (i - 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: stopwatchModel,
        builder: (context, model) {
          return ConstrainedBox(
            constraints: BoxConstraints.tight(
              Size(
                size,
                size,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                //Clock face
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  ),
                ),
                //Clock center
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                //Clock dots
                for (int i = 0; i <= 59; i++)
                  Positioned(
                    child: Transform.translate(
                      offset: dotOffset(i),
                      child: Container(
                        width: i % 5 == 0 ? 4 : 2,
                        height: i % 5 == 0 ? 4 : 2,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ),
                //Clock numbers
                for (int i = 0; i <= 11; i++)
                  Positioned(
                    child: Transform.translate(
                      offset: numberOffset(i),
                      child: Text(
                        (i + 1).toString(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                //Clock hands
                RotationTransition(
                    turns: stopwatchModel.elapsedTime.inMilliseconds == 0
                        ? const AlwaysStoppedAnimation(0)
                        : AlwaysStoppedAnimation(
                            stopwatchModel.elapsedTime.inMilliseconds /
                                60 /
                                1000),
                    child: ClockHandWidget(
                      color: Colors.red,
                      length: 0.7 * size,
                      width: 1,
                    )),
                RotationTransition(
                    turns: stopwatchModel.elapsedTime.inMilliseconds == 0
                        ? const AlwaysStoppedAnimation(0)
                        : AlwaysStoppedAnimation(
                            stopwatchModel.elapsedTime.inMilliseconds /
                                60 /
                                60 /
                                1000),
                    child: ClockHandWidget(
                      color: Theme.of(context).colorScheme.secondary,
                      length: 0.6 * size,
                      width: 2,
                    )),
                RotationTransition(
                    turns: stopwatchModel.elapsedTime.inMinutes == 0
                        ? const AlwaysStoppedAnimation(0)
                        : AlwaysStoppedAnimation(
                            stopwatchModel.elapsedTime.inMinutes / 60 / 12),
                    child: ClockHandWidget(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      length: 0.4 * size,
                      width: 3,
                    )),
              ],
            ),
          );
        });
  }
}

class ClockHandWidget extends StatelessWidget {
  const ClockHandWidget({
    super.key,
    required this.length,
    required this.width,
    required this.color,
  });

  final double length;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: length,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            stops: const [
              0.5,
              1,
              1,
            ],
            colors: [
              color,
              color,
              Colors.transparent,
            ]),
      ),
    );
  }
}
