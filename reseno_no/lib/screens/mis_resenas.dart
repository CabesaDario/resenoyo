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
    Query resenasRef = FirebaseFirestore.instance
        .collection('resenas')
        .where('user', isEqualTo: prefs.email);
    prefs.ultimaPagina = MisResenas.routeName;
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('tus reseñas'),
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: resenasRef.get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                final List<DocumentSnapshot> documents = snapshot.data.docs;
                return ListView(
                    children: documents
                        .map((doc) => Card(
                              child: ListTile(
                                title: Text(doc['peli']),
                                subtitle: Text(doc['text']),
                              ),
                            ))
                        .toList());
              }
            }));
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
      'time': time,
      'rating': rating,
    };
  }
}
/*ListView.separated(
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
          )*/
