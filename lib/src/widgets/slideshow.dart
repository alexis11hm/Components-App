import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool upDots;
  final Color primaryColor;
  final Color secondaryColor;
  final double bulletPrimario;
  final double bulletSecundario;

  const Slideshow(
      {@required this.slides,
      this.upDots = false,
      this.primaryColor = Colors.blue,
      this.secondaryColor = Colors.grey,
      this.bulletPrimario = 12.0,
      this.bulletSecundario = 12.0});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => new _SlideshowModel(),
        child: SafeArea(
          child: Center(
            child: Builder(
              builder: (BuildContext context) {
                Provider.of<_SlideshowModel>(context).primaryColor =
                    this.primaryColor;
                Provider.of<_SlideshowModel>(context).secondaryColor =
                    this.secondaryColor;
                Provider.of<_SlideshowModel>(context).bulletPrimario =
                    this.bulletPrimario;
                Provider.of<_SlideshowModel>(context).bulletSecundario =
                    this.bulletSecundario;
                return _SlideshowStructure(upDots: upDots, slides: slides);
              },
            ),
          ),
        ));
  }
}

class _SlideshowStructure extends StatelessWidget {
  const _SlideshowStructure({
    @required this.upDots,
    @required this.slides,
  });

  final bool upDots;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (this.upDots) _Dots(this.slides.length),
        Expanded(child: _Slides(this.slides)),
        if (!this.upDots) _Dots(this.slides.length),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int dotsAmount;

  const _Dots(this.dotsAmount);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(dotsAmount, (index) => _Dot(index))),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot(this.index);
  @override
  Widget build(BuildContext context) {
    final slideshowModel = Provider.of<_SlideshowModel>(context);
    double tamanio = 0;
    Color color;

    if (slideshowModel.currentPage >= (index - 0.5) &&
        slideshowModel.currentPage < index + 0.5) {
      tamanio = slideshowModel.bulletPrimario;
      color = slideshowModel.primaryColor;
    } else {
      tamanio = slideshowModel.bulletSecundario;
      color = slideshowModel.secondaryColor;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: tamanio,
      height: tamanio,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides(this.slides);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
      pageViewController.addListener(() {
        //Update sliderModel instance,if provider is in initState listen must be false
        Provider.of<_SlideshowModel>(context, listen: false).currentPage =
            pageViewController.page;
      });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(10),
        child: slide);
  }
}

class _SlideshowModel extends ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.grey;
  double _bulletPrimario = 12.0;
  double _bulletSecundario = 12.0;

  double get currentPage => this._currentPage;

  set currentPage(double pagina) {
    this._currentPage = pagina;
    print(pagina);
    notifyListeners();
  }

  Color get primaryColor => this._primaryColor;

  set primaryColor(Color color) {
    this._primaryColor = color;
  }

  Color get secondaryColor => this._secondaryColor;

  set secondaryColor(Color color) {
    this._secondaryColor = color;
  }

  double get bulletPrimario => this._bulletPrimario;

  set bulletPrimario(double primario) {
    this._bulletPrimario = primario;
  }

  double get bulletSecundario => this._bulletSecundario;

  set bulletSecundario(double secundario) {
    this._bulletSecundario = secundario;
  }
}
