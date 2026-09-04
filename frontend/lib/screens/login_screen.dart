// frontend/lib/screens/login_screen.dart
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Aquí guardaremos los números que la persona vaya tocando
  String pinIngresado = '';

  // Función que se ejecuta cada vez que tocan un número
  void _agregarNumero(String numero) {
    if (pinIngresado.length < 4) {
      setState(() {
        pinIngresado += numero;
      });
      // Si ya ingresaron 4 números, aquí iría la lógica para mandarlos al Node.js
      if (pinIngresado.length == 4) {
        _validarPin();
      }
    }
  }

  // Función para borrar el último número
  void _borrarNumero() {
    if (pinIngresado.isNotEmpty) {
      setState(() {
        pinIngresado = pinIngresado.substring(0, pinIngresado.length - 1);
      });
    }
  }

  // Función simulada (pronto la conectaremos a tu API)
  void _validarPin() {
    print('Intentando hacer login con el PIN: $pinIngresado');
    // Para probar visualmente, mostraremos un mensajito abajo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Validando PIN: $pinIngresado...')),
    );
    // Vaciamos el PIN después de probar
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        pinIngresado = '';
      });
    });
  }

  // Widget para crear un botón circular del teclado
  Widget _botonNumero(String numero) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _agregarNumero(numero),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24),
          backgroundColor: Colors.brown[100], // Color del botón
          foregroundColor: Colors.brown[900], // Color del texto
        ),
        child: Text(numero, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.coffee, size: 80, color: Colors.brown),
            const SizedBox(height: 20),
            const Text(
              'TRENZA CAFÉ Y LIBROS',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown),
            ),
            const SizedBox(height: 40),
            const Text('Ingrese su PIN de acceso', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            // Los asteriscos visuales del PIN
            Text(
              pinIngresado.padRight(4, '*'), // Si hay menos de 4, rellena con *
              style: const TextStyle(fontSize: 40, letterSpacing: 10),
            ),
            const SizedBox(height: 40),
            // El teclado numérico (3 filas)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_botonNumero('1'), _botonNumero('2'), _botonNumero('3')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_botonNumero('4'), _botonNumero('5'), _botonNumero('6')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_botonNumero('7'), _botonNumero('8'), _botonNumero('9')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 80), // Espacio vacío para alinear el 0 al centro
                _botonNumero('0'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: _borrarNumero,
                    icon: const Icon(Icons.backspace, size: 30, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}