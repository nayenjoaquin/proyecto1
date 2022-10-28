import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto1/pages/principal.dart';
import 'package:proyecto1/services/loginService.dart';
import 'package:proyecto1/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final pref;

  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future<void> validarDatos(String email, String password) async {
    final response = await LoginService().validar(email, password);

    if (response.statusCode == 200) {
      //almacenar de alguna manera el login

      await pref.setString('usuario', email);

      Global.login = email;
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Principal()));
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'El pepe ete sech',
        loopAnimation: false,
      );
    }
  }

  String? loginGuardado = "";

  @override
  void initState() {
    super.initState();
    cargaPreferencia();
  }

  void cargaPreferencia() async {
    pref = await SharedPreferences.getInstance();
    loginGuardado = pref.getString("usuario");
    mailController.text = loginGuardado == null ? "" : loginGuardado!;
  }

  @override
  Widget build(BuildContext context) {

    const gap = SizedBox(height: 20);
    const loginImg = Image(
      image: AssetImage('assets/loginImg-modified.png',),
      height: 300,
    );
    const inputColor = Color.fromARGB(255, 201, 197, 255);
    const iconColor = Color.fromARGB(255, 59, 61, 163);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Inicia sesión',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                    ),
                  ),
                ),
                loginImg,
                TextField(
                  controller: mailController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inputColor),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    filled: true,
                    fillColor: inputColor,
                    hintText: 'Ingrese su email',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: iconColor),
                  ),
                ),
                gap,
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inputColor),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    filled: true,
                    fillColor: inputColor,
                    hintText: 'Ingrese su contraseña',
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock, color: iconColor),
                  ),
                ),
                gap,
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (mailController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Ingrese un email valido",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        validarDatos(
                            mailController.text, passController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: iconColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Ingresar',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}