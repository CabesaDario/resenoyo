import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reseno_no/providers/peliculas_provider.dart';
import 'package:reseno_no/widgets/card_swiper_widget.dart';

class HomeScreen extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Populares'),
        leading: Container(),
      ),
        body: Container(
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _swiperPeliculas(),
              _footer(context),
            ],
          )),
        ));
  }
  Widget _swiperPeliculas() {
    return FutureBuilder(
        future: peliculasProvider.getEnCines(),
        builder : (BuildContext context, AsyncSnapshot<List> snapshot){
          if(snapshot.hasData){
            return CardSwiper(peliculas: snapshot.data);
          }else{
            return Container(height: 400.0, child:
                              Center(child:
                                   CircularProgressIndicator()));
          }
        }
    );

  }
  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text('Populares', style: Theme.of(context).textTheme.subtitle1,),

        ],
      )
    );
  }
}



