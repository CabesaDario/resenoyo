import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_login/flutter_login.dart';
import 'package:reseno_no/screens/HomeScreen.dart';

const users = const {
  'cabesa@gmail.com': '2232',
  'otro@gmail.com': 'puff',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    print('Nombre: ${data.name}, Pass: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'El usuario indicado no existe';
      }
      if (users[data.name] != data.password) {
        return 'La contraseña indicada no existe';
      }
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
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
    return FlutterLogin(
      title: 'ReseñoÑo',
      logo: 'assets/images/ecorp-lightblue.png',
      emailValidator: (value) {
        if (!value!.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}