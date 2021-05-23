import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //No se usan estas propiedades, es
  //por motivos docentes
  //bool _colorSecundario;
  //int _genero;
  //String _nombre;

  //GET y SET del genero
  get darkMode {
    return _prefs.getBool('dark_mode') ?? false;
  }

  set darkMode(bool value) {
    _prefs.setBool('dark_mode', value);
  }

  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  //GET y SET del color secundario
  get cantidadPopulares {
    return _prefs.getInt('cantidad_pop') ?? 5;
  }

  set cantidadPopulares(int value) {
    _prefs.setInt('cantidad_pop', value);
  }

  //GET y SET del nombre de usuario
  get nombreUsuario {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs.setString('nombreUsuario', value);
  }

  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? '/';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}
