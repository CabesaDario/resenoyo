import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reseno_no/models/peliculas_model.dart';
import 'package:reseno_no/widgets/menu_slider.dart';

class ResenaScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _ratingController;
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;
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
              print(_ratingController);
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
                /*TODO mostrar snackbar*/
                print('Hecho');
              }),
        ],
      ),
    );
  }
}
