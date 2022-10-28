import 'package:flutter/material.dart';
import 'package:proyecto1/models/Mensajes.dart';
import 'package:proyecto1/services/msjService.dart';
import '../global.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {

  late Future<Mensajes> futureMensajes;

  @override
  void initState() {
    super.initState();
    fetchMensajes();
  }

  void fetchMensajes() async {
    final response = await MsjService().getMsjs();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
