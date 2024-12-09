import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RealTimeCameraScreen extends StatefulWidget {
  @override
  _RealTimeCameraScreenState createState() => _RealTimeCameraScreenState();
}

class _RealTimeCameraScreenState extends State<RealTimeCameraScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  String detectionResult = "Esperando detección...";
  Timer? _timer;
  bool isProcessing = false;
  String? processedImageBase64;
  bool showFullScreen = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras.first, 
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _initializeControllerFuture = _cameraController.initialize();
    setState(() {});
    startRealTimeProcessing();
  }

  @override
  void dispose() {
    stopRealTimeProcessing();
    _cameraController.dispose();
    super.dispose();
  }

  void startRealTimeProcessing() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (!isProcessing) {
        captureAndSendImage();
      }
    });
  }

  void stopRealTimeProcessing() {
    _timer?.cancel();
  }

  Future<void> captureAndSendImage() async {
    try {
      isProcessing = true;
      await _initializeControllerFuture;
      final image = await _cameraController.takePicture();

      final response = await sendImageToServer(image.path);
      setState(() {
        detectionResult = response['resultado'];
        processedImageBase64 = response['processed_image'];
      });
    } catch (e) {
      print("Error al capturar la imagen: $e");
    } finally {
      isProcessing = false;
    }
  }

  Future<Map<String, dynamic>> sendImageToServer(String imagePath) async {
    try {
      final bytes = await File(imagePath).readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse('https://09dd-132-251-2-227.ngrok-free.app/process_image'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'image': base64Image}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'resultado': "Error del servidor: ${response.statusCode}",
          'processed_image': null
        };
      }
    } catch (e) {
      print("Error al enviar la imagen: $e");
      return {
        'resultado': "Error al conectar con el servidor",
        'processed_image': null
      };
    }
  }

  Widget _buildProcessedImage({bool fullScreen = false}) {
    if (processedImageBase64 == null) return Container();
    
    return Container(
      height: fullScreen ? double.infinity : 200,
      width: double.infinity,
      child: Image.memory(
        base64Decode(processedImageBase64!),
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detección de Señas en Tiempo Real'),
        actions: [
          IconButton(
            icon: Icon(showFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
            onPressed: () {
              setState(() {
                showFullScreen = !showFullScreen;
              });
            },
          ),
        ],
      ),
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
            children: [
              Expanded(
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Stack(
                        children: [
                          // Mostrar la cámara solo si no estamos en pantalla completa
                          if (!showFullScreen) CameraPreview(_cameraController),
                          
                          // Imagen procesada
                          if (processedImageBase64 != null)
                            showFullScreen
                              ? _buildProcessedImage(fullScreen: true)
                              : Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showFullScreen = true;
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                      child: _buildProcessedImage(),
                                    ),
                                  ),
                                ),
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.black87,
                child: Text(
                  detectionResult,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
