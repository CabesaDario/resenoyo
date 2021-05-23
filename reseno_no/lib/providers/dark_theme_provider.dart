import 'package:flutter/material.dart';
import 'package:reseno_no/shared_pref/preferencias_usuario.dart';

class DarkThemeProvider with ChangeNotifier {
  final prefs = new PreferenciasUsuario();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }
}
