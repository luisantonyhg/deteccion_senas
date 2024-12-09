import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DetectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtén los argumentos enviados como un Map
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Extrae el valor que necesitas
    final String userName = arguments['userName'];
    final int userId = arguments['userId'];
    print("DETECCION EL NOMBRE: $userName");
    print("ESTAS DETECCION EL ID: $userId");

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
          // Contenido encima de la imagen de fondo
          Column(
            children: [
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
                            width: 90,
                            height: 70,
                          ),
                        ),
                        Text(
                          "Detección de Señales",
                          style: TextStyle(
                            fontFamily: 'Figtree',
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ],
                ),
              ),

              // Tarjeta con información del usuario
              Container(
                margin: EdgeInsets.symmetric(horizontal: 34),
                height: 120,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/baseDetencion2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/images/circuloImaDetencion.png'),
                          ),
                          SizedBox(width: 10),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Usuario",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                userName ?? 'Usuario',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.edit, color: Colors.white.withOpacity(0.7)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(),

              // Botón para iniciar la detección con una imagen detrás
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 410,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/baseVertiticalDetencion.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      // Solicitar permiso de cámara
                      if (await Permission.camera.request().isGranted) {
                        // Si el permiso es otorgado, navega a la vista de la cámara
                        Navigator.pushNamed(context, '/real_time_camera');
                      } else {
                        print("Permiso de cámara no otorgado");
                        // Opcional: mostrar mensaje o alerta de permiso denegado
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Permiso de cámara denegado"),
                          ),
                        );
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/circulodetencion.png',
                          width: 290,
                          height: 240,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Iniciar Detección",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Figtree',
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Image.asset(
                              'assets/images/camaradetencion.png',
                              width: 60,
                              height: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
