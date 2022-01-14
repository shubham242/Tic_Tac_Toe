import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/custom_colors.dart';

class Cross extends StatefulWidget {
  @override
  _CrossState createState() => _CrossState();
}

class _CrossState extends State<Cross> with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double>? _animation;
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {
          _fraction = _animation!.value;
        });
      });

    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomPaint(
              painter: CrossPainter(_fraction),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class CrossPainter extends CustomPainter {
  final double fraction;
  var _circlePaint;

  CrossPainter(this.fraction) {
    _circlePaint = Paint()
      ..color = CROSS_COLOR
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var p1 = Offset(0, 0);
    var p2 = Offset(size.height * (fraction >= 0.5 ? 1 : fraction * 2),
        size.height * (fraction >= 0.5 ? 1 : fraction * 2));
    var p3 = Offset(
        size.height -
            size.height * (fraction >= 0.5 ? (fraction - 0.5) * 2 : 0),
        size.height * (fraction >= 0.5 ? (fraction - 0.5) * 2 : 0));
    var p4 = Offset(size.height, 0);

    canvas.drawLine(p1, p2, _circlePaint);

    canvas.drawLine(p4, p3, _circlePaint);
  }

  @override
  bool shouldRepaint(CrossPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
