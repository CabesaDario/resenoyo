import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reseno_no/providers/peliculas_provider.dart';
import 'package:reseno_no/search/search_delegate.dart';
import 'package:reseno_no/shared_pref/preferencias_usuario.dart';
import 'package:reseno_no/widgets/card_swiper_widget.dart';
import 'package:reseno_no/widgets/menu_slider.dart';
import 'package:reseno_no/widgets/movie_horizontal.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = 'home';
  final peliculasProvider = PeliculasProvider();
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    prefs.ultimaPagina = HomeScreen.routeName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate:
                      DataSearch(), /*query: 'Este 3er argumento hace que se prerellene la barra de busqueda con este texto'*/
                );
              })
        ],
      ),
      drawer: NavDrawer(),
      body: Container(
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Género: ${prefs.genero}'),
            _swiperPeliculas(),
            _footer(context),
          ],
        )),
      ),
    );
  }

  Widget _swiperPeliculas() {
    return FutureBuilder(
        future: peliculasProvider.getEnCines(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(peliculas: snapshot.data);
          } else {
            return Container(
                height: 400.0,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget _footer(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Populares',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            SizedBox(height: 5.0),
            StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontal(
                    peliculas: snapshot.data,
                    siguientePagina: peliculasProvider.getPopulares,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ));
  }
}
