// frontend/lib/main.dart
import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';

void main() {
  runApp(const PosTrenzaApp());
}

class PosTrenzaApp extends StatelessWidget {
  const PosTrenzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS Trenza Café',
      theme: ThemeData(
        // Colores de la cafetería (puedes cambiarlos luego)
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
    );
  }
}