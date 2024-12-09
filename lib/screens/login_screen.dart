import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final String correo = emailController.text;
    final String contrasena = passwordController.text;

    // Validación de campos
    if (correo.isEmpty || contrasena.isEmpty) {
      _showDialog(context, "Error", "Por favor completa todos los campos");
      return;
    }

      final url = Uri.parse('https://780e-132-191-1-42.ngrok-free.app/login'); // Cambia a tu URL de backend

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "correo": correo,
          "contraseña": contrasena,
        }),
      );

    if (response.statusCode == 200) {
    final responseData = json.decode(response.body);

    final String userName = responseData["usuario"]["nombre"];
    final int userId = responseData["usuario"]["id"]; 
  Navigator.pushNamed(
  context,
  '/profile',
  arguments: {
    'userName': userName,
    'userId': userId
    },
);

}

    else if (response.statusCode == 401) {
              _showDialog(context, "Error", "Correo o contraseña incorrectos");
            } else {
              _showDialog(context, "Error", "Error en el inicio de sesión");
            }
    } catch (e) {
      print("Error: $e");
      _showDialog(context, "Error", "Error de conexión");
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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
                // Logos de "SIGNA" y "VISION"
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
                
                // Título "Iniciar Sesión"
                Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontFamily: 'Figtree',
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 9),

                // Campo de correo
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

                // Campo de contraseña
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
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reset_password');
                  },
                  child: Text(
                    "¿Olvidaste tu contraseña?",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 5),
                // Botón de inicio de sesión
                GestureDetector(
                  // onTap: () => loginUser(context),
                   onTap: () {
                    // Comentado: loginUser(context);
                    Navigator.pushNamed(
                      context,
                      '/profile', 
                      arguments: {
                    'userName': "prueba",
                    'userId': 10
                    }, // Aquí se pasa el nombre de la ruta a la vista de perfil
                    );
                  },
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
                        "Ingresar",
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
                SizedBox(height: 15),

                // Línea divisoria y texto
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

                // Enlace de registro
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    "¿No tienes cuenta? Regístrate",
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
