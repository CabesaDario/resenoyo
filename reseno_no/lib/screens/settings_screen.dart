import 'package:flutter/material.dart';
import 'package:reseno_no/shared_pref/preferencias_usuario.dart';
import 'package:reseno_no/widgets/menu_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _colorSecundario = false;
  int _genero;
  String _nombre = 'Pedro';

  TextEditingController _textController;

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _textController = new TextEditingController(text: _nombre);
  }

  cargarPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _genero = prefs.getInt('genero');
    setState(() {});
  }

  _setSelectedRadio(int valor) async {
    prefs.genero = valor;
    _genero = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ajustes'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(),
        SwitchListTile(
          value: _colorSecundario,
          title: Text('Color secundario'),
          onChanged: (value) {
            setState(() {
              _colorSecundario = value;
              prefs.colorSecundario = value;
            });
          },
        ),
        RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio),
        RadioListTile(
          value: 2,
          title: Text('Femenino'),
          groupValue: _genero,
          onChanged: _setSelectedRadio,
        ),
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el teléfono'),
            onChanged: (value) {},
          ),
        ),
      ]),
    );
  }
}
