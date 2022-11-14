import 'package:flutter/material.dart';

import 'db/db_usuario.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda de Contactos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                DBusuario.db.initDatabase();
              },
              child: Text("Mostrar data"),
            ),
          ],
        ),
      ),
    );
  }
}