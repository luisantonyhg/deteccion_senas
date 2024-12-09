import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetectionHistoryScreen extends StatefulWidget {
  @override
  _DetectionHistoryScreenState createState() => _DetectionHistoryScreenState();
}

class _DetectionHistoryScreenState extends State<DetectionHistoryScreen> {
  late Future<List<dynamic>> detectionsFuture;
  late String userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recibe los argumentos pasados al navegar a esta pantalla
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userId = arguments['userId'].toString();

    // Llama a la función fetchDetections con el userId recibido
    detectionsFuture = fetchDetections(userId);
  }

  Future<List<dynamic>> fetchDetections(String userId) async {
    final response = await http.post(
      Uri.parse('https://780e-132-191-1-42.ngrok-free.app/get_user_detections'), // Cambia a la URL de tu backend
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'usuario_id': userId}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Si no hay detecciones, devuelve una lista vacía en lugar de lanzar una excepción
      return data['detecciones'] ?? [];
    } else {
      throw Exception('Error al obtener el historial de detecciones');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo con imagen y diseño
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
                          "Historial de Detección",
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
              SizedBox(height: 20),
              // Lista de historial
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: detectionsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Ningún historial de Detección',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No se encontraron detecciones.',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      );
                    } else {
                      final detections = snapshot.data!;
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: detections.length,
                        itemBuilder: (context, index) {
                          final detection = detections[index];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(detection['imagen_url']), // Imagen de la detección
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Detección Nº ${detection['deteccion_id']}",
                                        style: TextStyle(
                                          color: Colors.lightBlueAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${detection['fecha_detencion']}\nTipo: ${detection['tipo_detencion']}",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.favorite_border, color: Colors.white),
                                  onPressed: () {
                                    // Acción al presionar favorito
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
