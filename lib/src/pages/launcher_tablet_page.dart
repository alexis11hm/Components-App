import 'package:custom_painter/src/models/layout_model.dart';
import 'package:custom_painter/src/pages/slideshow_page.dart';
import 'package:custom_painter/src/routes/routes.dart';
import 'package:custom_painter/src/theme/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LauncherTabletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final layoutModel = Provider.of<LayoutModel>(context);
    return Scaffold(
        drawer: _MenuPrincipal(),
        appBar: AppBar(
          backgroundColor: appTheme.currentTheme.accentColor,
          title: Text('Flutter Tablet Designs'),
        ),
        body: Row(
          children: <Widget>[
            Container(
              width: 300,
              height: double.infinity,
              child: _ListaOpciones(),
            ),
            Container(
              width: 1,
              height: double.infinity,
              color: (appTheme.darkTheme)
                  ? Colors.grey
                  : appTheme.currentTheme.accentColor,
            ),
            Expanded(
              child: layoutModel.currentPage,
            )
          ],
        ));
  }
}

class _ListaOpciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return ListView.separated(
        physics: BouncingScrollPhysics(),
        separatorBuilder: (context, i) => Divider(
              color: appTheme.primaryColorLight,
            ),
        itemCount: pageRoutes.length,
        itemBuilder: (context, i) => ListTile(
              leading: FaIcon(
                pageRoutes[i].icon,
                color: appTheme.accentColor,
              ),
              title: Text('${pageRoutes[i].titulo}'),
              trailing: Icon(
                Icons.chevron_right,
                color: appTheme.accentColor,
              ),
              onTap: () {
                final layoutModel =
                    Provider.of<LayoutModel>(context, listen: false);
                layoutModel.currentPage = pageRoutes[i].page;
              },
            ));
  }
}

class _MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.accentColor;
    return Drawer(
      child: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: accentColor,
                  child: Text(
                    'AHM',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
              Expanded(child: _ListaOpciones()),
              ListTile(
                leading: Icon(Icons.lightbulb_outline, color: accentColor),
                title: Text('Dark Mode'),
                trailing: Switch.adaptive(
                    activeColor: accentColor,
                    value: appTheme.darkTheme,
                    onChanged: (value) {
                      appTheme.darkTheme = value;
                    }),
              ),
              ListTile(
                leading: Icon(Icons.add_to_home_screen, color: accentColor),
                title: Text('Custom Theme'),
                trailing: Switch.adaptive(
                    activeColor: accentColor,
                    value: appTheme.customTheme,
                    onChanged: (value) {
                      appTheme.customTheme = value;
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
