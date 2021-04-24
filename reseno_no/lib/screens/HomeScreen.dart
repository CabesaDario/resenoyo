import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:reseno_no/providers/peliculas_provider.dart';
import 'package:reseno_no/widgets/card_swiper_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Populares'),
        leading: Container(),
      ),
        body: Container(
          child: (Column(
            children: [
              _swiperPeliculas(),
            ],
          )),
        ));
  }
}

  Widget _swiperPeliculas() {
    return CardSwiper(
        peliculas : [1,2,3,4,5]
    );

  }
