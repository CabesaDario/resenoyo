import 'package:flutter/material.dart';
import 'package:reseno_no/models/peliculas_model.dart';
import 'package:reseno_no/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'La cosa',
    'El orfanato',
    'Lo que el viento se llevó',
    'El exorcista',
    'La milla verde'
  ];

  final peliculasRecientes = ['Midsommar', 'Hereditary', 'Us'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Son las acciones de nuestro search, ejemplo, un iconito para limpiar el texto
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del search/appbar
    return IconButton(
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_arrow,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando el usuario escribe

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(
                      image: NetworkImage(pelicula.getPosterImg()),
                      placeholder: AssetImage('assets/image/no-image.jpg')),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: () {
                    close(context, null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle',
                        arguments: pelicula);
                  },
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
