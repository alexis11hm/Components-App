import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  @override
  _CircularProgressPageState createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double percentage = 0.0;
  double nuevoPorcentaje = 0.0;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    controller.addListener(() {
      //print('Valor Controller: ${controller.value}');
      setState(() {
        percentage = lerpDouble(percentage, nuevoPorcentaje,
            controller.value); //Interpolar 2 numbers
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5.0),
          width: 300.0,
          height: 300.0,
          child: CustomPaint(
            painter: _MiRadialProgress(percentage),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.orange,
        onPressed: () {
          percentage = nuevoPorcentaje;
          nuevoPorcentaje += 10;
          if (nuevoPorcentaje > 100) {
            nuevoPorcentaje = 0;
          }

          controller.forward(from: 0.0);

          setState(() {});
        },
      ),
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  final percentage;
  _MiRadialProgress(this.percentage);
  @override
  void paint(Canvas canvas, Size size) {
    //Completed Circle
    final paint = Paint()
      ..strokeWidth = 5.0
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;
    final center = new Offset(size.width * 0.5, size.height * 0.5);
    final radio = math.min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radio, paint);

    //Arco
    final paintArco = Paint()
      ..strokeWidth = 10.0
      ..color = Colors.orange
      ..style = PaintingStyle.stroke;
    //Part to fill arco
    double arcAngle = 2 * math.pi * (percentage / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radio), -math.pi / 2,
        arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
