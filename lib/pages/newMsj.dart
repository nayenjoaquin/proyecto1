import 'package:flutter/material.dart';
import 'package:proyecto1/pages/principal.dart';
import 'package:proyecto1/services/msjService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto1/global.dart';
import 'package:cool_alert/cool_alert.dart';

class NewMsj extends StatefulWidget {
  const NewMsj({super.key});

  @override
  State<NewMsj> createState() => _NewMsjState();
}

class _NewMsjState extends State<NewMsj> {
  late final pref;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<void> validarDatos(String titulo, String texto) async {
    var login = Global.login;
    final response = await MsjService().validar(login, titulo, texto);

    if (response.statusCode == 201) {
      Navigator.push(context, 
        MaterialPageRoute(builder: (context) => const Principal()));
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Error al enviar el mensaje',
        loopAnimation: false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    pref = SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromARGB(255, 59, 61, 163);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Mensaje'),
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Contenido',
                ),
                maxLines: null,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      contentController.text.isEmpty) {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      title: 'Oops...',
                      text: 'Debe llenar todos los campos',
                      loopAnimation: false,
                    );
                  } else {
                    validarDatos(titleController.text, contentController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                ),
                child: const Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
