import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseno_no/providers/dark_theme_provider.dart';
import 'package:reseno_no/shared_pref/preferencias_usuario.dart';

class NavDrawer extends StatelessWidget {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              prefs.nombreUsuario,
              style: TextStyle(
                fontSize: 45.0,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(10.0, 10.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  Shadow(
                    offset: Offset(10.0, 10.0),
                    blurRadius: 8.0,
                    color: Color.fromARGB(125, 0, 0, 255),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/slider-background.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Películas populares'),
            onTap: () => {Navigator.pushNamed(context, 'home')},
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Mis reseñas'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, 'mis_resenas')
            },
          ),
          /*ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ), TODO implementar pantalla de perfil de usuario y de feedback si es necesario*/
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ajustes'),
            onTap: () => {Navigator.pushNamed(context, 'settings')},
          ),
          /*ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),*/
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              themeChange.darkTheme = false,
              Navigator.of(context).pushReplacementNamed('loguin')
            },
          ),
        ],
      ),
    );
  }
}
