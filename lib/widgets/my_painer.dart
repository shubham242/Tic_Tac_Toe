import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  int result;
  BuildContext context;
  MyPainter(this.result, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    double w = MediaQuery.of(context).size.width;
    var p1 = Offset(0, 0);
    var p2 = Offset(0, 0);
    if (result == 1) {
      p1 = Offset(w / 6, w / 6);
      p2 = Offset(5 * w / 6, 5 * w / 6);
    }
    if (result == 2) {
      p1 = Offset(5 * w / 6, w / 6);
      p2 = Offset(w / 6, 5 * w / 6);
    }
    if (result == 3) {
      p1 = Offset(w / 6, w / 6);
      p2 = Offset(5 * w / 6, w / 6);
    }
    if (result == 4) {
      p1 = Offset(w / 6, w / 2);
      p2 = Offset(5 * w / 6, w / 2);
    }
    if (result == 5) {
      p1 = Offset(w / 6, 5 * w / 6);
      p2 = Offset(5 * w / 6, 5 * w / 6);
    }
    if (result == 6) {
      p1 = Offset(w / 6, w / 6);
      p2 = Offset(w / 6, 5 * w / 6);
    }
    if (result == 7) {
      p1 = Offset(w / 2, w / 6);
      p2 = Offset(w / 2, 5 * w / 6);
    }
    if (result == 8) {
      p1 = Offset(5 * w / 6, w / 6);
      p2 = Offset(5 * w / 6, 5 * w / 6);
    }
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.cyanAccent.withOpacity(0.7)
      ..strokeWidth = 15;

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
