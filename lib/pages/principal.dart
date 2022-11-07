import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto1/navBar.dart';
import '../global.dart';
import 'package:intl/intl.dart';
import 'package:proyecto1/pages/newMsj.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  fetchMensajes() async {
    var url;
    url = await http
        .get(Uri.parse('https://fcfab46d0f16.sa.ngrok.io/api/mensajes'));

    return json.decode(url.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const NewMsj()));
        },
        backgroundColor: const Color.fromARGB(255, 59, 61, 163),
        child: const Icon(Icons.add),
      ),
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Mensajes'),
        backgroundColor: const Color.fromARGB(255, 59, 61, 163),
      ),
      body: FutureBuilder(
        future: fetchMensajes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 150,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                snapshot.data[index]['login'].toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(DateTime.parse(
                                      snapshot.data[index]['fecha']))
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              snapshot.data[index]['titulo'].toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            Text(
                              snapshot.data[index]['texto'],
                              textAlign: TextAlign.justify,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              onRefresh: () async {
                setState(() {});
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
