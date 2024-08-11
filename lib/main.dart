import 'package:flutter/material.dart';
import 'vistasinicio/login.dart';
import 'vistasinicio/registro.dart';
import 'vistasinicio/pantallas/inicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/registro': (context) => const RegistroView(),
        '/inicio': (context) => const InicioView(),

      },
      debugShowCheckedModeBanner: false, // Esto oculta la etiqueta de depuración
    );
  }
}