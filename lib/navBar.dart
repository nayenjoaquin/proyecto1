import 'package:flutter/material.dart';
import 'package:proyecto1/global.dart';
import 'package:proyecto1/pages/login.dart';
import 'package:proyecto1/pages/newMsj.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Global.login == null
                ? const Text('No hay usuario')
                : Text(Global.login!),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 59, 61, 163),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Agregar'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewMsj()));
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Integrantes'),
            onTap: () {
              print('Integrantes');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () {
              Global.login = '';
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
