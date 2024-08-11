import 'package:flutter/material.dart';
import 'package:crud_odalis/models/usuario.dart'; // Asegúrate de que esta ruta sea correcta
import 'package:crud_odalis/base/base.dart'; // Asegúrate de que esta ruta sea correcta

class InicioView extends StatefulWidget {
  const InicioView({Key? key}) : super(key: key);

  @override
  _InicioViewState createState() => _InicioViewState();
}

class _InicioViewState extends State<InicioView> {
  late Future<List<Usuario>> _usuariosFuture;

  @override
  void initState() {
    super.initState();
    _usuariosFuture = DatabaseHelper().getAllUsers(); // Cargar usuarios al inicio
  }

  void _logout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cerrando sesión...')),
    );
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _performAction(Usuario usuario) {
    // Implementa la acción a realizar con el usuario aquí
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Acción para ${usuario.nombre}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inicio',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 189, 153, 225),
      ),
      body: Container(
        // Fondo degradado
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Lista de usuarios registrados',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9, // Ajusta el ancho aquí
                  child: FutureBuilder<List<Usuario>>(
                    future: _usuariosFuture,
                    builder: (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No hay usuarios disponibles.'));
                      } else {
                        final usuarios = snapshot.data!;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 12,
                            dataRowHeight: 50, // Ajustar altura de filas
                            columns: const <DataColumn>[
                              DataColumn(label: Text('Nombre')),
                              DataColumn(label: Text('Correo')),
                              DataColumn(label: Text('Acciones')),
                            ],
                            rows: usuarios.map((usuario) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('${usuario.nombre} ${usuario.apellidos}', style: TextStyle(fontSize: 12))),
                                  DataCell(Text(usuario.correo, style: TextStyle(fontSize: 12))),
                                  DataCell(
                                    IconButton(
                                      icon: const Icon(Icons.edit, size: 20),
                                      onPressed: () => _performAction(usuario),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _logout,
                child: const Text('Cerrar sesión'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red, // Color del botón
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}