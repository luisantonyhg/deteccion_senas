import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false; // Variable para controlar el estado de carga

  Future<void> requestPasswordReset() async {
    setState(() {
      _isLoading = true; // Mostrar el icono de carga
    });

    final email = _emailController.text;
    final response = await http.post(
      Uri.parse('https://b443-132-251-2-146.ngrok-free.app/request_password_reset'), // Cambia a la URL de tu servidor
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    setState(() {
      _isLoading = false; // Ocultar el icono de carga después de la respuesta
    });

    if (response.statusCode == 200) {
      // Mostrar el mensaje en un dialog en lugar de SnackBar
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Éxito'),
            content: Text('Correo de recuperación enviado'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/verificartoken');
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${jsonDecode(response.body)['mensaje']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo que ocupa toda la pantalla
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondopantallageneral.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              // Cabecera con el botón de regreso
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/detencionAtras.png',
                        width: 80,
                        height: 90,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/signa.png',
                        width: 150,
                      ),
                      SizedBox(height: 2),
                      Image.asset(
                        'assets/images/vision.png',
                        width: 150,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Recuperar contraseña',
                        style: TextStyle(
                          fontFamily: 'Figtree',
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "@gmail.com",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'TuTipografia',
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 195, 195, 209),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.white, width: 1.5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: requestPasswordReset,
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
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  ) // Muestra el icono de carga si está cargando
                                : Text(
                                    "Recuperar",
                                    style: TextStyle(
                                      fontFamily: 'Figtree',
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
