import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reseno_no/models/actores_model.dart';
import 'package:reseno_no/models/peliculas_model.dart';
import 'package:reseno_no/providers/peliculas_provider.dart';
import 'package:reseno_no/shared_pref/preferencias_usuario.dart';
import 'package:reseno_no/widgets/menu_slider.dart';

class PeliculaDetalle extends StatelessWidget {
  static final String routeName = 'detalle';
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    prefs.ultimaPagina = PeliculaDetalle.routeName;
    return Scaffold(
      drawer: NavDrawer(),
      body: CustomScrollView(
        slivers: [
          _crearAppbar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _posterTitulo(pelicula, context),
              _descripcion(pelicula),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              _crearResenas(pelicula),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              _crearCasting(pelicula),
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'resena', arguments: pelicula);
        },
        child: const Icon(Icons.book),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.indigoAccent,
        expandedHeight: 200.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(pelicula.title,
              style: TextStyle(color: Colors.white, fontSize: 16.0)),
          background: FadeInImage(
              image: NetworkImage(pelicula.getBackgroundImg()),
              placeholder: AssetImage('assets/images/loading.gif'),
              fadeInDuration: Duration(milliseconds: 150),
              fit: BoxFit.cover),
        ));
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(pelicula.getPosterImg()),
                  height: 150.0,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pelicula.title,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    pelicula.originalTitle,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_border),
                      Text(
                        pelicula.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview +
            "\n\nFecha de estreno: " +
            pelicula.releaseDate +
            "\n\nPara adultos: " +
            (pelicula.adult ? "Sí" : "No") +
            "\n\nTítulo original: " +
            pelicula.originalTitle,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearResenas(Pelicula pelicula) {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('peliculas')
        .doc('${pelicula.id}')
        .collection('${pelicula.title}');
    return FutureBuilder(
        future: collectionReference
            .orderBy('popularidad', descending: true)
            .limit(5)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data.docs.length == 0) {
            return ListTile(
              leading: Icon(Icons.book_online),
              title: Text(
                  'Nadie ha añadido una reseña de esta película todavía. ¡Sé el primero!'),
            );
          } else {
            final documents = snapshot.data.docs;
            FixedExtentScrollController fixedExtentScrollController =
                new FixedExtentScrollController();
            return Container(
              height: 200,
              child: ListWheelScrollView(
                  controller: fixedExtentScrollController,
                  physics: FixedExtentScrollPhysics(),
                  itemExtent: 70.0,
                  children: documents
                      .map<Widget>((doc) => Card(
                            child: ListTile(
                              title: Text(
                                doc['resena'],
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(doc['nick'].length == 0
                                  ? 'Anónimo'
                                  : doc['nick']),
                            ),
                          ))
                      .toList()),
            );
          }
        });
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Colaborador> actores) {
    return SizedBox(
        height: 200.0,
        child: PageView.builder(
          pageSnapping: false,
          itemCount: actores.length,
          controller: PageController(viewportFraction: 0.3, initialPage: 1),
          itemBuilder: (context, index) => _actorTarjeta(actores[index]),
        ));
  }

  Widget _actorTarjeta(Colaborador actor) {
    return Container(
        child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
              height: 150.0,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(actor.getPhoto())),
        ),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ));
  }
}
