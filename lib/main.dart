import 'package:custom_painter/src/models/layout_model.dart';
import 'package:custom_painter/src/pages/launcher_page.dart';
import 'package:custom_painter/src/pages/launcher_tablet_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:custom_painter/src/theme/theme_changer.dart';
import 'package:provider/single_child_widget.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (_) => new LayoutModel(),
    child: ChangeNotifierProvider(
        create: (_) => new ThemeChanger(2), child: MyApp())));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Provider.of<ThemeChanger>(context).currentTheme,
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            final screenSize = MediaQuery.of(context).size;
            if (screenSize.width > 500) {
              //if screen size is bigger that 500 pixels, then
              //we can work tablet mode
              return LauncherTabletPage();
            } else {
              return LauncherPage();
            }
            /*  print('$orientation');
            return Container(
              child: LauncherPage(),
            ); */
          },
        ));
  }
}
