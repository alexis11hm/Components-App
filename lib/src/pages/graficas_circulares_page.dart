import 'package:custom_painter/src/theme/theme_changer.dart';
import 'package:custom_painter/src/widgets/radial_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraficasCircularPage extends StatefulWidget {
  @override
  _GraficasCircularPageState createState() => _GraficasCircularPageState();
}

class _GraficasCircularPageState extends State<GraficasCircularPage> {
  double porcentaje = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(
                porcentaje: porcentaje * 1.2,
                color: Colors.blue,
              ),
              CustomRadialProgress(
                porcentaje: porcentaje * 4,
                color: Colors.red,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(
                porcentaje: porcentaje * 6,
                color: Colors.purple,
              ),
              CustomRadialProgress(
                porcentaje: porcentaje * 2.5,
                color: Colors.pink,
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: () {
            setState(() {
              porcentaje += 10;
              if (porcentaje > 100) {
                porcentaje = 0;
              }
            });
          }),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  const CustomRadialProgress({@required this.porcentaje, @required this.color});

  final double porcentaje;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return Container(
      width: 170.0,
      height: 170.0,
      child: RadialProgress(
        porcentaje: porcentaje,
        colorPrimario: color,
        colorSecundario: appTheme.textTheme.body1.color,
        grosorSecundario: 10,
        grosorPrimario: 10,
      ),
    );
  }
}
