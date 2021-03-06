import 'package:custom_painter/src/theme/theme_changer.dart';
import 'package:custom_painter/src/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accentColor =
        Provider.of<ThemeChanger>(context).currentTheme.accentColor;
    return Scaffold(body: HeaderWave(color: accentColor));
  }
}
