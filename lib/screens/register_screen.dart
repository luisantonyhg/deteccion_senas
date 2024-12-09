import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    final String nombre = nameController.text;
    final String correo = emailController.text;
    final String contrasena = passwordController.text;

    // Verificar si algún campo está vacío
    if (nombre.isEmpty || correo.isEmpty || contrasena.isEmpty) {
      _showErrorDialog(context, "Por favor, complete todos los campos.");
      return;
    }
    final url = Uri.parse('https://780e-132-191-1-42.ngrok-free.app/register'); // Cambia esto con tu URL real

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nombre": nombre,
          "correo": correo,
          "contrasena": contrasena,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Registro exitoso"),
              content: Text(responseData["mensaje"]),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/login'); // Redirigir al login después del registro
                  },
                  child: Text("Aceptar"),
                ),
              ],
            );
          },
        );
      } else {
        final errorData = json.decode(response.body);
        _showErrorDialog(context, errorData["mensaje"]);
      }
    } catch (e) {
      print("Error: $e");
      _showErrorDialog(context, "Error de conexión");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
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
                // Logo de Signa Vision
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

                // Título
                Text(
                  'Regístrate',
                  style: TextStyle(
                    fontFamily: 'Figtree',
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),

                // Campo de texto para el nombre
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: "Nombre",
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                      filled: true,
                      fillColor: Color.fromARGB(255, 22, 22, 41),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Campo de texto para el correo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: "@gmail.com",
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                      filled: true,
                      fillColor: Color.fromARGB(255, 22, 22, 41),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Campo de texto para la contraseña
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: "Contraseña",
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                      filled: true,
                      fillColor: Color.fromARGB(255, 22, 22, 41),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 15),
                
                // Botón de registro con degradado
                GestureDetector(
                  onTap: () {
                    registerUser(context);
                  },
                  child: Container(
                    width: 230,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF5EAB), // Rosado
                          Color(0xFF00D4FF), // Turquesa
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Registrar",
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
                // Línea divisoria y texto de redes sociales
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.5),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "o regístrate usando",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.5),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),

                // Iconos de redes sociales
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => print("Iniciar sesión con Twitter"),
                      child: Image.asset(
                        'assets/images/twitter.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => print("Iniciar sesión con Facebook"),
                      child: Image.asset(
                        'assets/images/facebook.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => print("Iniciar sesión con Google"),
                      child: Image.asset(
                        'assets/images/google.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Texto de "¿ya tienes cuenta?"
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "¿Ya tienes una cuenta? Inicia sesión",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Figtree',
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
