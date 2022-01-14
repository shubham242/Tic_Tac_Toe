import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  final String title;
  final double size;
  final FontWeight weight;
  final Color color;
  Txt(
    this.title, {
    this.size = 14,
    this.color = Colors.black,
    this.weight = FontWeight.normal,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
