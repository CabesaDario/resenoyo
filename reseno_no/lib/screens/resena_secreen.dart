import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reseno_no/models/peliculas_model.dart';
import 'package:reseno_no/shared_pref/preferencias_usuario.dart';
import 'package:reseno_no/widgets/menu_slider.dart';

// ignore: must_be_immutable
class ResenaScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  static final String routeName = 'resena';
  final prefs = new PreferenciasUsuario();
  final snackBarComplete = SnackBar(content: Text('Su reseña se ha subido'));
  final snackBarBad = SnackBar(
      content: Text('La reseña es demasiado corta para ser publicada'));
  double _ratingController = 3.0;

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = ResenaScreen.routeName;
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;
    prefs.ultimaPagina = ResenaScreen.routeName;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Añade una reseña'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(pelicula.title),
            subtitle: Text(pelicula.releaseDate),
            trailing: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 50.0,
            ),
          ),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              _ratingController = rating;
            },
          ),
          Flexible(
            child: Container(
              width: _screenSize.width * 0.7,
              child: TextField(
                controller: _textEditingController,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ),
          TextButton(
              child: Text('Reseñar'),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if (_textEditingController.text.length <= 5) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBarBad);
                } else {
                  agregarResena(
                      _textEditingController.text, pelicula, _ratingController);
                  _textEditingController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(snackBarComplete);
                }
              }),
        ],
      ),
    );
  }

  Future<void> agregarResena(
      String resena, Pelicula pelicula, double puntuasione) async {
    //la referencia a la coleccion de reseñas de esa pelicula
    CollectionReference resenasRef =
        FirebaseFirestore.instance.collection('resenas');
    DocumentReference usuarioRef =
        FirebaseFirestore.instance.collection('usuarios').doc(prefs.email);
    await resenasRef.add({
      'user': prefs.email,
      'text': resena,
      'peli': pelicula.title,
      'rating': puntuasione,
      'time': DateTime.now(),
      'poster_path': pelicula.posterPath,
    }).then((value) => usuarioRef.update({'${value.id}': '${value.id}'}));
  }
}
