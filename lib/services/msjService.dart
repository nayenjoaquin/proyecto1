import 'package:http/http.dart' as http;
import 'package:proyecto1/models/mensajes.dart';

class MsjService {
  Future<Mensajes> getMsjs() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/msjs'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },  
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Mensajes.fromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}