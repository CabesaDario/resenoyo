import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reseno_no/screens/mis_resenas.dart';
import 'package:reseno_no/widgets/menu_slider.dart';
import 'package:intl/intl.dart';

class ResenaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO añadir hero animation al navegar aqui y reducir velocidad de transicion de todos los heros
    final formatter = new DateFormat('yyyy-MM-dd');
    final Resena resena = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MisResenas(),
        ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reseña de ${resena.peli}'),
          centerTitle: true,
        ),
        drawer: NavDrawer(),
        body: Column(
          children: [
            ListTile(
              title: Text(resena.peli),
              subtitle: Text(formatter.format(resena.time)),
              trailing: Image(
                image: NetworkImage(getPosterImage(resena.poster)),
                height: 50.0,
              ),
            ),
            RatingBar.builder(
              initialRating: resena.rating,
              ignoreGestures: true,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(15.0),
                width: _screenSize.width * 0.5,
                child: Text(
                  resena.text,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getPosterImage(data) {
    if (data == '' || data == null) {
      return 'https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101065/112815953-no-image-available-icon-flat-vector.jpg?ver=6';
    }
    return 'https://image.tmdb.org/t/p/w500/$data';
  }
}
