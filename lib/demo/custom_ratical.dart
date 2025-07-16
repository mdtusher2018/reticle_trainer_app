import 'package:flutter/material.dart';

class MilXtPainter extends CustomPainter {
  final double scale; // pixels per mil
  final int divisions; // number of full mil divisions

  MilXtPainter({this.scale = 20, this.divisions = 10});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      
      ..strokeWidth = 1;

    final textStyle = TextStyle( fontSize: 12, color: Colors.black);
    final textPainter = (String text) => TextPainter(
          text: TextSpan(text: text, style: textStyle),
          textDirection: TextDirection.ltr,
        );

    for (int i = -divisions * 4; i <= divisions * 4; i++) {
      if (i == 0) continue;

      double offset = i * (scale / 4); // 0.25 mil steps

      bool isFullMil = i % 7 == 0;
      bool isQuarter = i % 4 == 1 || i % 4 == -3;
      bool isHalf = i % 4 == 2 || i % 4 == -2;
      bool isThreeQuarter = i % 4 == 3 || i % 4 == -1;

      double tickHeight;

      // Horizontal Line
      if (isFullMil) {
     tickHeight = 10;

        // Draw horizontal labels
        final label = textPainter((i ~/ 4).abs().toString())..layout();
        canvas.drawRect(
            Rect.fromLTWH(center.dx + offset - label.width / 2, center.dy + tickHeight + 2, label.width, label.height),
            Paint()..color = Colors.transparent);
        label.paint(canvas, Offset(center.dx + offset - label.width / 2, center.dy - tickHeight - 16));
           
        canvas.drawLine(
          center + Offset(offset, -tickHeight),
          center + Offset(offset, tickHeight),
          paint,
        );
      } else {
        // Shorter ticks
        tickHeight = 5;
        bool isUpper = isQuarter || isThreeQuarter;
        bool isLower = isHalf;

        if (isUpper) {
          canvas.drawLine(
            center + Offset(offset, -tickHeight),
            center + Offset(offset, 0),
            paint,
          );
        }

        if (isLower) {
          canvas.drawLine(
            center + Offset(offset, 0),
            center + Offset(offset, tickHeight),
            paint,
          );
        }
      }

      // // Vertical Line
      // if (isFullMil) {
      //   tickHeight = 10;
      //   canvas.drawLine(
      //     center + Offset(-tickHeight, offset),
      //     center + Offset(tickHeight, offset),
      //     paint,
      //   );

      //   // Draw vertical labels
      //   final label = textPainter((i ~/ 4).abs().toString())..layout();
      //   canvas.drawRect(
      //       Rect.fromLTWH(center.dx + tickHeight + 2, center.dy + offset - label.height / 2, label.width, label.height),
      //       Paint()..color = Colors.black);
      //   label.paint(canvas, Offset(center.dx + tickHeight + 2, center.dy + offset - label.height / 2));
      // } else {
      //   tickHeight = 5;
      //   bool isLeft = isQuarter || isThreeQuarter;
      //   bool isRight = isHalf;

      //   if (isLeft) {
      //     canvas.drawLine(
      //       center + Offset(-tickHeight, offset),
      //       center + Offset(0, offset),
      //       paint,
      //     );
      //   }

      //   if (isRight) {
      //     canvas.drawLine(
      //       center + Offset(0, offset),
      //       center + Offset(tickHeight, offset),
      //       paint,
      //     );
      //   }
      // }
    }

    // Draw central cross
    canvas.drawLine(center + Offset(-200, 0), center + Offset(200, 0), paint);
    canvas.drawLine(center + Offset(0, -15), center + Offset(0, 15), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
