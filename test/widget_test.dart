import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:detencion_senas/main.dart'; // Ajusta el nombre del paquete según tu proyecto

void main() {
  testWidgets('La app se inicia mostrando el texto Bienvenido', (WidgetTester tester) async {
    // Construye el widget `MyApp` dentro del entorno de prueba.
    await tester.pumpWidget(MyApp());

    // Busca un widget que contenga el texto "Bienvenido".
    expect(find.text('Bienvenido'), findsOneWidget);
  });
}
