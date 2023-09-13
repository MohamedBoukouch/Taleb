// import "dart:math";

// import "package:flutter/material.dart";
// import "package:taleb/app/config/themes/app_theme.dart";

// class circleprogress extends CustomPainter {
//   late final int i;
//   circleprogress(this.i);
  
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint circle = Paint()
//       ..strokeWidth = 3
//       ..color = AppTheme.box_color
//       ..style = PaintingStyle.stroke;
//     Offset center = Offset(size.width / 2, size.height / 2);
//     double radius = 28;
//     canvas.drawCircle(center, radius, circle);
//     //
//     Paint animationarc = Paint()
//       ..strokeWidth = 3
//       ..color = AppTheme.reed_color
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//     double angle = -2 * pi * (i / 100);
//     canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 2,
//         angle, false, animationarc);
//   }

//   @override
//   bool shouldRepaint(circleprogress oldDelegate) => false;

//   @override
//   bool shouldRebuildSemantics(circleprogress oldDelegate) => false;
// }
