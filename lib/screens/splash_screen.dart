import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simula una carga y navega automáticamente a la pantalla de inicio de sesión después de 2 segundos
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo que ocupa toda la pantalla
          Image.asset(
            'assets/images/paginaprincipal.png',
            fit: BoxFit.cover,
          ),
          // Puedes agregar más widgets aquí si es necesario, como un logo o texto en el centro
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ), // Indicador de carga opcional
          ),
        ],
      ),
    );
  }
}
