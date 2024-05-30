import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'bubble_snackbar_painter.dart';

class BubbleSnackbar extends StatefulWidget {
  final String message;
  final SnackBarAction? action;

  const BubbleSnackbar({
    super.key,
    required this.message,
    this.action,
  });

  @override
  State<BubbleSnackbar> createState() => _BubbleSnackbarState();
}

class _BubbleSnackbarState extends State<BubbleSnackbar> {
  final List<Offset> _points = [];
  final List<Offset> _velocities = [];

  final random = Random();
  late final Timer timer;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final width = MediaQuery.sizeOf(context).width;
        const height = 70.0;
        for (int i = 0; i < 20; i++) {
          _points.add(
            Offset(
              random.nextDouble() * width,
              random.nextDouble() * height,
            ),
          );
          _velocities.add(
            Offset(
              random.nextDouble() * 1 - .5,
              random.nextDouble() * 1 - .5,
            ),
          );
        }
        timer = Timer.periodic(
          const Duration(milliseconds: 16),
          (timer) {
            for (int i = 0; i < _points.length; i++) {
              _points[i] += _velocities[i];
              if (_points[i].dx < 0 || _points[i].dx > width) {
                _velocities[i] = Offset(-_velocities[i].dx, _velocities[i].dy);
              }
              if (_points[i].dy < 0 || _points[i].dy > height) {
                _velocities[i] = Offset(_velocities[i].dx, -_velocities[i].dy);
              }
            }
            setState(() {});
          },
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.pink,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CustomPaint(
          painter: BubblePainter(
            _points,
            _velocities,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (widget.action != null)
                  TextButton(
                    onPressed: widget.action!.onPressed,
                    child: Text(
                      widget.action!.label,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
