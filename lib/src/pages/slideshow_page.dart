import 'package:custom_painter/src/theme/theme_changer.dart';
import 'package:custom_painter/src/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlideshowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLarge;
    if (MediaQuery.of(context).size.height > 500)
      isLarge = true;
    else
      isLarge = false;

    final children = [
      Expanded(child: MiSlideshow()),
      Expanded(child: MiSlideshow())
    ];

    return Scaffold(
        body: (isLarge)
            ? Column(
                children: children,
              )
            : Row(
                children: children,
              ));
  }
}

class MiSlideshow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.accentColor;
    return Slideshow(
      bulletPrimario: 15,
      bulletSecundario: 12,
      primaryColor: (appTheme.darkTheme) ? accentColor : Colors.green,
      secondaryColor: Colors.grey,
      upDots: false,
      slides: <Widget>[
        SvgPicture.asset('assets/slideshow/1.svg'),
        SvgPicture.asset('assets/slideshow/2.svg'),
        SvgPicture.asset('assets/slideshow/3.svg'),
        SvgPicture.asset('assets/slideshow/4.svg'),
        SvgPicture.asset('assets/slideshow/5.svg'),
        SvgPicture.asset('assets/slideshow/6.svg'),
      ],
    );
  }
}
