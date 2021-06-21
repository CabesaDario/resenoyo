import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reseno_no/providers/dark_theme_provider.dart';
import 'package:reseno_no/screens/login_screen.dart';
import 'package:reseno_no/screens/mis_resenas.dart';
import 'package:reseno_no/screens/pelicula_detalle.dart';
import 'package:reseno_no/screens/resena_detalle.dart';
import 'package:reseno_no/screens/resena_secreen.dart';
import 'package:reseno_no/screens/settings_screen.dart';
import 'package:reseno_no/shared_pref/preferencias_usuario.dart';
import 'package:reseno_no/style/custom_dark_mode.dart';

import 'screens/home_screen.dart';

Future<void> main() async {
  final prefs = new PreferenciasUsuario();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = PreferenciasUsuario();
  final DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
        return MaterialApp(
          title: 'ReseñoÑo',
          debugShowCheckedModeBanner: false, //quita la marca de agua del debug
          theme: Styles.mainTheme(themeChangeProvider.darkTheme, context),
          initialRoute: 'loguin',
          routes: {
            'loguin': (context) => LoginScreen(),
            'resena_detalle': (context) => ResenaDetalle(),
            HomeScreen.routeName: (context) => HomeScreen(),
            SettingsScreen.routeName: (context) => SettingsScreen(),
            MisResenas.routeName: (context) => MisResenas(),
            PeliculaDetalle.routeName: (context) => PeliculaDetalle(),
            ResenaScreen.routeName: (context) => ResenaScreen(),
          },
        );
      }),
    );
  }
}
