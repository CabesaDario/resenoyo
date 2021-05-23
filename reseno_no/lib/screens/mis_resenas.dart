import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reseno_no/shared_pref/preferencias_usuario.dart';
import 'package:reseno_no/widgets/menu_slider.dart';

class MisResenas extends StatefulWidget {
  static final String routeName = 'mis_resenas';
  @override
  _MisResenasState createState() => _MisResenasState();
}

class _MisResenasState extends State<MisResenas> {
  final prefs = new PreferenciasUsuario();
  final List<String> listaRefs = [];

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = MisResenas.routeName;

    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('tus reseñas'),
        ),
        body: FutureBuilder<List<String>>(
          future: sacarReferencias(prefs.email),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data.length == 0) {
              return Center(child: Text("Aún no has añadido ninguna reseña"));
            } else {
              return listaFutureBuilder(snapshot.data);
            }
          },
        ));
  }

  Future<List<String>> sacarReferencias(String email) async {
    //CREar un método que devuelva un futuro de lista de reseñas
    //mirar el de star wars
    //1a peticion -> obtengo todos los ids, una vez tenga todos los ids, hago peticiones
    //a nivel individual para obtener las reseñas a nivel individual y todo ello con sus respectivos awaits
    final List<String> listaIds = [];
    final DocumentReference pelisResenadas =
        FirebaseFirestore.instance.collection('usuarios').doc(email);
    await pelisResenadas.get().then((value) {
      listaIds.addAll(value.data().keys);
    });
    return listaIds;
  }

  Widget listaFutureBuilder(List<String> refs) {
    final CollectionReference resenaRef =
        FirebaseFirestore.instance.collection('resenas');
    return ListView.builder(
        itemCount: refs.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
              future: resenaRef.doc('${refs[index]}').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Card(
                    child: ListTile(
                      leading: Image(
                          image: NetworkImage(
                              getPosterImage(snapshot.data['poster_path']))),
                      title: Text(snapshot.data['text'],
                          overflow: TextOverflow.ellipsis),
                      subtitle: Text(snapshot.data['rating'].toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.details),
                        onPressed: () {
                          Navigator.pushNamed(context, 'resena_detalle',
                              arguments: new Resena(
                                  poster: snapshot.data['poster_path'],
                                  text: snapshot.data['text'],
                                  peli: snapshot.data['peli'],
                                  time: snapshot.data['time'].toDate(),
                                  rating: snapshot.data['rating']));
                        },
                      ),
                    ),
                  );
                }
              });
        });
  }

  String getPosterImage(data) {
    if (data == '' || data == null) {
      return 'https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101065/112815953-no-image-available-icon-flat-vector.jpg?ver=6';
    }
    return 'https://image.tmdb.org/t/p/w500/$data';
  }
}

class Resena {
  Resena({
    @required this.text,
    @required this.peli,
    @required this.time,
    @required this.rating,
    @required this.poster,
  });

  /*Resena.fromJson(Map<String, Object> json)
      : this(
          text: json['text'] as String,
          peli: json['peli'] as String,
          time: json['time'] as DateTime,
          rating: json['rating'] as double,
        );*/

  final String text;
  final String poster;
  final String peli;
  final double rating;
  final DateTime time;

  /*Map<String, Object> toJson() {
    return {
      'text': text,
      'peli': peli,
      'time': time,
      'rating': rating,
    };
  }*/
}
