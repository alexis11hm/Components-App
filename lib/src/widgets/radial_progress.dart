import 'package:flutter/material.dart';
import 'dart:math' as math;

class RadialProgress extends StatefulWidget {
  final porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorSecundario;
  final double grosorPrimario;

  const RadialProgress(
      {@required this.porcentaje,
      this.colorPrimario = Colors.pink,
      this.colorSecundario = Colors.grey,
      this.grosorSecundario = 5.0,
      this.grosorPrimario = 10.0});

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double porcentajeAnterior;

  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
                painter: _MiRadialProgress(
                    (widget.porcentaje - diferenciaAnimar) +
                        (diferenciaAnimar * controller.value),
                    widget.colorPrimario,
                    widget.colorSecundario,
                    widget.grosorSecundario,
                    widget.grosorPrimario)));
      },
    );
    /**/
  }
}

class _MiRadialProgress extends CustomPainter {
  final percentage;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorSecundario;
  final double grosorPrimario;
  _MiRadialProgress(this.percentage, @required this.colorPrimario,
      this.colorSecundario, this.grosorSecundario, this.grosorPrimario);
  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = new LinearGradient(
        colors: <Color>[Color(0xFFC012F3), Color(0xFF6D05E8), Colors.red]);

    final Rect rect = new Rect.fromCircle(
      center: Offset(0, 0),
      radius: 180,
    );

    //Completed Circle
    final paint = Paint()
      ..strokeWidth = grosorSecundario
      ..color = colorSecundario
      ..style = PaintingStyle.stroke;
    final center = new Offset(size.width * 0.5, size.height * 0.5);
    final radio = math.min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radio, paint);

    //Arco
    final paintArco = Paint()
      ..strokeWidth = grosorPrimario
      //..color = colorPrimario
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
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
