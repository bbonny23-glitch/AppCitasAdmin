// Archivo: lib/main.dart

import 'package:flutter/material.dart';

void main() {
  runApp(const AdministradorApp());
}

// 1. EL WIDGET PRINCIPAL DE LA APLICACIÓN
class AdministradorApp extends StatelessWidget {
  const AdministradorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panel de Administrador',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // La primera pantalla que se mostrará
      home: const AdminLoginPage(), 
    );
  }
}

// 2. LA PANTALLA DE INICIO DE SESIÓN
class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  // Variables para guardar lo que el usuario escribe en los campos
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _mensajeError = '';

  // Función que se ejecutará cuando se presione el botón de Login
  void _iniciarSesion() {
    // Aquí pondremos el código de conexión a Firebase
    // Por ahora, solo muestra lo que escribimos
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _mensajeError = 'Por favor, ingrese correo y contraseña.';
      });
      return;
    }
    
    // Si la conexión fuera exitosa (simulación):
    setState(() {
      _mensajeError = 'Intento de inicio de sesión con: $email. ¡FALTA CONECTAR A FIREBASE!';
    });

    // En un proyecto real, aquí navegaríamos a la pantalla principal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administración'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Acceso de Administrador',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Campo para el Correo Electrónico
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              
              // Campo para la Contraseña
              TextField(
                controller: _passwordController,
                obscureText: true, // Oculta la contraseña
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 30),
              
              // Botón de Inicio de Sesión
              ElevatedButton(
                onPressed: _iniciarSesion,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Iniciar Sesión'),
              ),
              const SizedBox(height: 20),

              // Mensaje de Error
              Text(
                _mensajeError,
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// NO OLVIDES PRESIONAR CTRL + S (O CMD + S) PARA GUARDAR EL ARCHIVO.