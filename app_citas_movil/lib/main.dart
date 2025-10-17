// Archivo: lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart'; // Tu archivo de claves de conexión
import 'admin_dashboard.dart'; // El nuevo archivo Dashboard

// ***************************************************************
// 1. INICIALIZACIÓN DE FIREBASE Y FUNCIÓN PRINCIPAL
// ***************************************************************
void main() async {
  // Asegura que Flutter esté listo para inicializar servicios nativos
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa Firebase (ahora configurado para fallar si hay error, pero con la sintaxis correcta)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Ejecuta la aplicación
  runApp(const AdministradorApp());
}

// 2. WIDGET PRINCIPAL DE LA APLICACIÓN
class AdministradorApp extends StatelessWidget {
  const AdministradorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panel de Administrador de Citas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AdminLoginPage(), 
    );
  }
}

// ***************************************************************
// 3. PANTALLA DE INICIO DE SESIÓN (LOGIN)
// ***************************************************************
class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _mensajeError = '';
  bool _isLoading = false; 

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _iniciarSesion() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _mensajeError = 'Por favor, ingrese correo y contraseña.';
      });
      return;
    }
    
    setState(() {
      _isLoading = true; 
      _mensajeError = 'Intentando iniciar sesión...';
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Éxito: Navegar al Dashboard (CORRECCIÓN: SIN 'const' en la función)
      setState(() {
        _mensajeError = '¡INICIO DE SESIÓN EXITOSO!';
      });

      // ¡Navegación correcta!
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminDashboard()),
      );
      
    } on FirebaseAuthException catch (e) {
      // Manejar errores comunes de autenticación
      String errorMsg;
      if (e.code == 'user-not-found') {
        errorMsg = 'Usuario no encontrado. Revise el correo.';
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Contraseña incorrecta.';
      } else if (e.code == 'invalid-email') {
        errorMsg = 'Formato de correo inválido.';
      } else {
        // Si hay un error de conexión (clave incorrecta) caerá aquí:
        errorMsg = 'Error de conexión/autenticación: [${e.code}]';
      }
      
      setState(() {
        _mensajeError = errorMsg;
      });
      
    } finally {
      setState(() {
        _isLoading = false; 
      });
    }
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
              
              TextField(
                controller: _passwordController,
                obscureText: true, 
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 30),
              
              ElevatedButton(
                onPressed: _isLoading ? null : _iniciarSesion,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: _isLoading 
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                      )
                    : const Text('Iniciar Sesión'),
              ),
              const SizedBox(height: 20),

              // Mensaje de Error
              Text(
                _mensajeError,
                style: TextStyle(
                  color: _mensajeError.contains('EXITOSO') ? Colors.green : Colors.red, 
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}