// Archivo: lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'Plataforma no compatible con esta configuración manual.',
        );
    }
  }

  // CONFIGURACIÓN PARA WEB (Usada por Codespaces para probar)
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCheqF3AEZ7P7NjYeK8Z2k4anaDaZToMw4',
    appId: '1:772606968125:web:c4031a1e12f3613e248554',
    // CORRECCIÓN: Volver a String (con comillas)
    messagingSenderId: '772606968125', 
    projectId: 'citas-admin-app',
    authDomain: 'citas-admin-app.firebaseapp.com',
    // CORRECCIÓN CLAVE: Formato appspot.com
    storageBucket: 'citas-admin-app.appspot.com', 
  );

  // CONFIGURACIÓN BÁSICA PARA ANDROID (Reusa los mismos valores que Web)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCheqF3AEZ7P7NjYeK8Z2k4anaDaZToMw4',
    appId: '1:772606968125:web:c4031a1e12f3613e248554', 
    // CORRECCIÓN: Volver a String (con comillas)
    messagingSenderId: '772606968125',
    projectId: 'citas-admin-app',
    // CORRECCIÓN CLAVE: Formato appspot.com
    storageBucket: 'citas-admin-app.appspot.com',
  );
}