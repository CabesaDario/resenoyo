import 'dart:convert';

import 'package:reseno_no/models/peliculas_model.dart';
import 'package:http/http.dart' as http;
class PeliculasProvider {

  String _apiKey = '586f0be8c98f62a6b9d5645c14e521df';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language' : _language
    });

    final respuesta = await http.get( url );
    final decodedData = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;


  }
  Future<List<Pelicula>> getPopulares() async {

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apiKey,
      'language' : _language
    });

    final respuesta = await http.get( url );
    final decodedData = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;


  }





}