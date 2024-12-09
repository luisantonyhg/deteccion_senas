import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyTokenScreen extends StatefulWidget {



  @override
  _VerifyTokenScreenState createState() => _VerifyTokenScreenState();
}

class _VerifyTokenScreenState extends State<VerifyTokenScreen> {
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  Future<void> verifyTokenAndResetPassword() async {
    final token = _tokenController.text;
    final newPassword = _newPasswordController.text;

    // Primero, verifica el token
    final verifyResponse = await http.post(
      Uri.parse('https://b443-132-251-2-146.ngrok-free.app/verify_token'), // Cambia a la URL de tu servidor
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );

    if (verifyResponse.statusCode == 200) {
      final userId = jsonDecode(verifyResponse.body)['user_id'];

      // Si el token es válido, procede a cambiar la contraseña
      final resetResponse = await http.post(
        Uri.parse('https://b443-132-251-2-146.ngrok-free.app/reset_password'), // Cambia a la URL de tu servidor
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId, 'new_password': newPassword}),
      );

      if (resetResponse.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Contraseña actualizada exitosamente')),
        );
        Navigator.pushNamed(context, '/login'); // Redirige al login
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${jsonDecode(resetResponse.body)['mensaje']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Token no válido o expirado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondopantallageneral.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verificar Token y Cambiar Contraseña',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    controller: _tokenController,
                    decoration: InputDecoration(
                      hintText: "Código de recuperación",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Nueva contraseña",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: verifyTokenAndResetPassword,
                  child: Container(
                    width: 230,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF5EAB),
                          Color(0xFF00D4FF),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Cambiar Contraseña",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
