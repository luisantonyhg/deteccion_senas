import 'package:flutter/material.dart';
import 'routes/app_routes.dart'; // Importa las rutas

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta "Debug"
      initialRoute: '/', // Ruta inicial (pantalla de carga)
      routes: AppRoutes.getRoutes(), // Carga las rutas definidas en AppRoutes
      theme: ThemeData(
        primarySwatch: Colors.blue, // Configura el tema (puedes personalizarlo)
      ),
    );
  }
}

