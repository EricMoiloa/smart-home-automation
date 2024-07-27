import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';

import '../../utils/text_style.dart';


class CircularSeekBarExample extends StatefulWidget {
  const CircularSeekBarExample({Key? key}) : super(key: key);

  @override
  State<CircularSeekBarExample> createState() => _CircularSeekBarExampleState();
}

class _CircularSeekBarExampleState extends State<CircularSeekBarExample> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);

  double _progress = 90;

  bool _useGradient = true;

  bool _animation = true;
  bool _thumbVisible = true;
  bool _interactive = true;

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircularSeekBar(
              width: 100,
              progress: _progress,
              height: 100,
              progressGradientColors: _useGradient
                  ? [
                      Colors.red,
                      Colors.orange,
                      Colors.yellow,
                      Colors.green,
                      Colors.blue,
                      Colors.indigo,
                      Colors.purple
                    ]
                  : [],
              animation: _animation,
              curves: Curves.linear,
              innerThumbRadius: _thumbVisible ? 5 : 0,
              innerThumbStrokeWidth: _thumbVisible ? 3 : 0,
              outerThumbRadius: _thumbVisible ? 5 : 0,
              outerThumbStrokeWidth: _thumbVisible ? 10 : 0,
              valueNotifier: _valueNotifier,
              interactive: _interactive,
              child: Center(
                child: ValueListenableBuilder(
                    valueListenable: _valueNotifier,
                    builder: (_, double value, __) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${value.round()}',
                                style: kNotoSansBold16.copyWith(
                                    color: Colors.black45)),
                            Text('Brightness',
                                style: kNotoSansRegular14.copyWith(
                                    color: Colors.grey)),
                          ],
                        )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
