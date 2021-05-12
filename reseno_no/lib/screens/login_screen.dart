import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:reseno_no/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reseno_no/shared_pref/preferencias_usuario.dart';

const users = const {
  'cabesa@gmail.com': '2232',
  'otro@gmail.com': 'puff',
};
final FirebaseAuth _auth = FirebaseAuth.instance;
final prefs = new PreferenciasUsuario();

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _recoverPassword(String name) {
    print('Nombre: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'El nombre de usuario indicado no existe';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/the-thing.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: FlutterLogin(
        theme: LoginTheme(
          pageColorLight: Colors.transparent,
          pageColorDark: Colors.transparent,
        ),
        messages: LoginMessages(
            confirmPasswordError: 'Las contraseñas no coinciden',
            signupButton: 'Registrarse',
            forgotPasswordButton: '¿Olvidó la contraseña?'),
        emailValidator: (value) {
          return null;
          /*//todo quitar el null de ahi para que valide
          if (!value.contains('@') || !value.endsWith('.com')) {
            return "formato de email inválido";
          }
          return null;*/
        },
        passwordValidator: (value) {
          return null;
          //todo quitar el null de ahi para que valide
          /*if (value.isEmpty) {
            return 'La contraseña está vacía';
          }else if(value.length < 6){
            return 'Contraseña demasiado débil';
          }
          return null;*/
        },

        onLogin: (loginData) {
          return _signInWithEmailAndPassword(loginData);
        },
        onSignup: (loginData) {
          return _register(loginData.name, loginData.password);
        },
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            //para no poder volver con tecla back
            builder: (context) => HomeScreen(),
          ));
        }, // todo implementar esto o quitar la opción
        onRecoverPassword: _recoverPassword,
      ),
    );
  }

  Future<String> _signInWithEmailAndPassword(LoginData data) async {
    try {
      //await _auth.signInAnonymously();
      /*todo esto es la autentacion verdadera, cuando no quiera
          logarme anonimo, lo descomento*/
      User user = (await _auth.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      ))
          .user;
      prefs.email = user.email;
      return null;
    } on FirebaseAuthException {
      return 'Usuario y/o contraseña incorrectos';
    }
  }

  Future<String> _register(String email, String pass) async {
    User user;
    try {
      user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      ))
          .user;
      CollectionReference usuarios =
          FirebaseFirestore.instance.collection('usuarios');
      await usuarios
          .doc(email)
          .set({
            'name': email,
          })
          .then((value) => print("Usuario Añadido"))
          .catchError((error) => print("Error al añadir usuario: $error"));
      prefs.email = user.email;
    } on FirebaseAuthException {
      return 'El usuario indicado ya existe';
    }
    if (user != null) {
      return null;
    } else {
      return "Algo salió mal";
    }
  }
}
