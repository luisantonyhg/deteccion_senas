import 'package:flutter/material.dart';

class TrainingScreen extends StatelessWidget {
  final List<String> letterImages = [
    'assets/images/letraA.png',
    'assets/images/letraB.png',
    'assets/images/letraC.png',
    'assets/images/letraD.png',
    'assets/images/letraE.png',
    'assets/images/letraF.png',
    'assets/images/letraG.png',
    'assets/images/letraH.png',
    'assets/images/letraI.png',
    'assets/images/letraJ.png',
    'assets/images/letraK.png',
    'assets/images/letraL.png',
    'assets/images/letraM.png',
    'assets/images/letraN.png',
    'assets/images/letraO.png',
    'assets/images/letraP.png',
    'assets/images/letraQ.png',
    'assets/images/letraR.png',
    'assets/images/letraS.png',
    'assets/images/letraT.png',
    'assets/images/letraU.png',
    'assets/images/letraV.png',
    'assets/images/letraW.png',
    'assets/images/letraX.png',
    'assets/images/letraY.png',
    'assets/images/letraZ.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de pantalla principal
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondopantallageneral.png',
              fit: BoxFit.cover,
            ),
          ),
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
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Text(
                          "Entrenamiento de Señas",
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
              SizedBox(height: 10),
              // Fondo adicional detrás de las letras con Expanded
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: letterImages.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        letterImages[index],
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Texto de instrucción
              Text(
                "Practica Aprendiendo estas Señas",
                style: TextStyle(
                  fontFamily: 'Figtree',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              // Botón "Listo"
              GestureDetector(
                onTap: () {
                  // Acción de finalización del entrenamiento
                },
                child: Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "Listo",
                      style: TextStyle(
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10), // Añadido un espacio extra al final
            ],
          ),
        ],
      ),
    );
  }
}
