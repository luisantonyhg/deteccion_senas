import 'dart:ffi';

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {


  
  
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PageController _controller = PageController();
  final List<String> imagePaths = [
    'assets/images/detencioncarousel.png',
    'assets/images/detencioncarousel.png',
    'assets/images/detencioncarousel.png',
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Configura el cambio automático de página
    Future.delayed(Duration(seconds: 2), _autoPlay);
  }

  void _autoPlay() {
    if (_controller.hasClients) {
      _controller.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      setState(() {
        _currentIndex = (_currentIndex + 1) % imagePaths.length;
      });
      Future.delayed(Duration(seconds: 2), _autoPlay);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Obtén los argumentos enviados como un Map
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Extrae el valor que necesitas
    final String userName = arguments['userName'];
    final int userId = arguments['userId'];
    print("AQUI ESTAS RECIBIENDO EL NOMBRE: $userName");
    print("AQUI ESTAS RECIBIENDO EL ID: $userId");


  return Scaffold(
      body: Stack(
        children: [
          // Fondo de pantalla
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondopantallageneral.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Barra superior con íconos
              // AppBar personalizado
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/baseDetencion.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 130,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/images/detencionAtras.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        // Coloca los textos en una columna para centrar el nombre de usuario debajo del mensaje de bienvenida
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Bienvenidos a Signa Visión",
                              style: TextStyle(
                                fontFamily: 'Figtree',
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8), // Espacio entre los textos
                            Text(
                              userName ?? 'Usuario', 
                              style: TextStyle(
                                fontFamily: 'Figtree',
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Carousel Slider usando PageView
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(imagePaths[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

              // Texto de "Acciones"
              Text(
                "Acciones:",
                style: TextStyle(
                  fontFamily: 'Figtree',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),

              // Botones de acciones
              _buildActionButton(
                context,
                icon: Icons.camera,
                text: "Detección Tiempo Real",
                colors: [Color(0xFFFF5EAB), Color(0xFF00D4FF)],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detection',
                    arguments: {
                      'userName': userName,
                      'userId': userId
                      },
                  );
                },
              ),
              SizedBox(height: 10),
              _buildActionButton(
                context,
                icon: Icons.school,
                text: "Entrenamiento de Señas",
                colors: [Color(0xFFB066FE), Color(0xFF63E2FF)],
                onTap: () {
                  Navigator.pushNamed(context, '/training');
                },
              ),
              SizedBox(height: 10),
              _buildActionButton(
                context,
                icon: Icons.history,
                text: "Historial de Detección",
                colors: [Color(0xFF63E2FF), Color(0xFFFF5EAB)],
                onTap: () {
                 
                   Navigator.pushNamed(
                    context,
                    '/history',
                    arguments: {
                      'userName': userName,
                      'userId': userId
                      },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Función para crear cada botón de acción
  Widget _buildActionButton(BuildContext context,
      {required IconData icon,
      required String text,
      required List<Color> colors,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Figtree',
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
