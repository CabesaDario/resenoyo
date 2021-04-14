import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return Container(
      width: double.infinity,
      height: 300.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "http://via.placeholder.com/350x150", fit: BoxFit.fill,
          );
        },

        itemCount: 3,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );

  }
