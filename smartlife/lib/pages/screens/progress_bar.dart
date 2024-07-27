import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.width,
    required this.height,
    required this.progress,
  }) : super(key: key);

  final double width;
  final double height;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: width * progress,
            height: height,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FinalProgressBar extends StatefulWidget {
  const FinalProgressBar({Key? key}) : super(key: key);

  @override
  State<FinalProgressBar> createState() => _FinalProgressBarState();
}

class _FinalProgressBarState extends State<FinalProgressBar> {
  double percentage = 0.0;

  void updatePercentage(double dx) {
    setState(() {
      percentage = (percentage + dx / 200).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          updatePercentage(details.delta.dx);
        },
        onTapDown: (details) {
          final RenderBox box = context.findRenderObject() as RenderBox;
          final Offset localOffset = box.globalToLocal(details.globalPosition);
          final double newPercentage = localOffset.dx / box.size.width;
          setState(() {
            percentage = newPercentage.clamp(0.0, 1.0);
          });
        },
        onTapUp: (_) {
          // Add your logic here
          // For example, you can show a message when the tap is released
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tap released!'),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProgressBar(width: 200, height: 20, progress: percentage),
          ],
        ),
      ),
    );
  }
}
