import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reseno_no/models/peliculas_model.dart';
import 'package:reseno_no/shared_pref/preferencias_usuario.dart';
import 'package:reseno_no/widgets/menu_slider.dart';

class MisResenas extends StatelessWidget {
  static final String routeName = 'mis_resenas';
  final prefs = new PreferenciasUsuario();
  final List<Pelicula> pelis = [
    new Pelicula(
        posterPath: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
        adult: false,
        overview:
            "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
        releaseDate: "2016-08-03",
        genreIds: [14, 28, 80],
        id: 297761,
        originalTitle: "Suicide Squad",
        title: "Suicide Squad",
        backdropPath: "ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
        popularity: 48.261451,
        voteCount: 1466,
        video: false,
        voteAverage: 5.91),
    Pelicula(
        posterPath: "e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
        adult: false,
        overview:
            "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
        releaseDate: "2016-08-03",
        genreIds: [14, 28, 80],
        id: 297761,
        originalTitle: "Suicide Squad",
        title: "Suicide Squad",
        backdropPath: "ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
        popularity: 48.261451,
        voteCount: 1466,
        video: false,
        voteAverage: 5.91),
    Pelicula(
        posterPath: "e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
        adult: false,
        overview:
            "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
        releaseDate: "2016-08-03",
        genreIds: [14, 28, 80],
        id: 297761,
        originalTitle: "Suicide Squad",
        title: "Suicide Squad",
        backdropPath: "ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
        popularity: 48.261451,
        voteCount: 1466,
        video: false,
        voteAverage: 5.91),
    Pelicula(
        posterPath: "e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
        adult: false,
        overview:
            "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
        releaseDate: "2016-08-03",
        genreIds: [14, 28, 80],
        id: 297761,
        originalTitle: "Suicide Squad",
        title: "Suicide Squad",
        backdropPath: "ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
        popularity: 48.261451,
        voteCount: 1466,
        video: false,
        voteAverage: 5.91),
    Pelicula(
        posterPath: "e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
        adult: false,
        overview:
            "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
        releaseDate: "2016-08-03",
        genreIds: [14, 28, 80],
        id: 297761,
        originalTitle: "Suicide Squad",
        title: "Suicide Squad",
        backdropPath: "ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
        popularity: 48.261451,
        voteCount: 1466,
        video: false,
        voteAverage: 5.91),
  ];

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = MisResenas.routeName;
    List<Resena> resenas = [];
    for (int i = 0; i < pelis.length; i++) {
      resenas.add(new Resena(
          time: DateTime.now(),
          rating: 2.0,
          text: "Muy buena eh de verdad que esta chulisima hostias jajajajaja",
          peli: 'lo que el viento se llevó'));
    }
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title:
            Text('cabesas reseñas'), /*TODO SACAR EL USUARIO DE LA FIRESTORE*/
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: pelis.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              resenas[index].text,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Image(
                height: 50.0, image: NetworkImage(pelis[index].getPosterImg())),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}

class Resena {
  Resena(
      {@required this.text,
      @required this.peli,
      @required this.time,
      @required this.rating});

  Resena.fromJson(Map<String, Object> json)
      : this(
          text: json['text'] as String,
          peli: json['peli'] as String,
          time: json['time'] as DateTime,
          rating: json['rating'] as double,
        );

  final String text;
  final String peli;
  final double rating;
  final DateTime time;

  Map<String, Object> toJson() {
    return {
      'text': text,
      'peli': peli,
      'TIME': time,
      'rating': rating,
    };
  }
}
