import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseno_no/providers/dark_theme_provider.dart';
import 'package:reseno_no/shared_pref/preferencias_usuario.dart';
import 'package:reseno_no/widgets/menu_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static final String routeName = 'settings';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  int _cantidadPopulares;
  String _nombre = '';

  TextEditingController _textController;

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = SettingsScreen.routeName;
    _darkMode = prefs.darkMode;
    _cantidadPopulares = prefs.cantidadPopulares;
    _textController = new TextEditingController(text: _nombre);
  }

  /*cargarPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool('dark_mode');
    _cantidadPopulares = prefs.getInt('cantidad_pop');
    setState(() {});
  }*/

  _setSelectedRadio(int valor) async {
    prefs.cantidadPopulares = valor;
    _cantidadPopulares = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ajustes'),
      ),
      body: ListView(children: [
        Divider(),
        SwitchListTile(
          value: _darkMode,
          title: Text('Modo noche'),
          onChanged: (value) {
            setState(() {
              _darkMode = value;
              prefs.darkMode = value;
              themeChange.darkTheme = value;
            });
          },
        ),
        Divider(),
        Container(
            padding: EdgeInsets.all(15.0),
            child: Text('Cantidad de populares mostradas')),
        RadioListTile(
            value: 5,
            title: Text('5'),
            groupValue: _cantidadPopulares,
            onChanged: _setSelectedRadio),
        RadioListTile(
          value: 10,
          title: Text('10'),
          groupValue: _cantidadPopulares,
          onChanged: _setSelectedRadio,
        ),
        RadioListTile(
          value: 15,
          title: Text('15'),
          groupValue: _cantidadPopulares,
          onChanged: _setSelectedRadio,
        ),
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
                labelText: 'Nick', helperText: 'Tu nick de usuario'),
            onChanged: (value) {},
          ),
        ),
      ]),
    );
  }
}
