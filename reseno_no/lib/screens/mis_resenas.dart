import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reseno_no/models/peliculas_model.dart';
import 'package:reseno_no/widgets/menu_slider.dart';

class MisResenas extends StatelessWidget {
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
    List<Resena> resenas = [];
    for (int i = 0; i < pelis.length; i++) {
      resenas.add(new Resena(
          text: "Muy buena eh de verdad que esta chulisima hostias jajajajaja",
          peli: pelis[i]));
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
  String text;
  Pelicula peli;

  Resena({this.text, this.peli});
}
