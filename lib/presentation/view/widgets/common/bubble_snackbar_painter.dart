import 'package:flutter/material.dart';

class BubblePainter extends CustomPainter {
  final List<Offset> points;
  final List<Offset> velocities;
  BubblePainter(this.points, this.velocities);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink.withOpacity(.2)
      ..style = PaintingStyle.fill;
    const radius = 20.0;
    for (int i = 0; i < 20; i++) {
      final x = points[i].dx;
      final y = points[i].dy;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
