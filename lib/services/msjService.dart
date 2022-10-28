import 'dart:convert';
import 'package:http/http.dart' as http;

class MsjService {
  Future<http.Response> validar(
      String login, String titulo, String texto) async {
    return await http.post(
      Uri.parse('https://40fd422c6d4d.sa.ngrok.io/api/mensajes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'login': login, 'titulo': titulo, 'texto': texto}),
    );
  }
}
