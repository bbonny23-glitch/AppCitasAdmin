// Archivo: lib/admin_dashboard.dart
// Pantalla principal del administrador con navegación lateral.

import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    // 1. Calendario de Citas
    const Center(
      child: Text('1. VISTA DE CALENDARIO Y GESTIÓN DE CITAS', style: TextStyle(fontSize: 24)),
    ),
    // 2. Historial de Usuarios
    const Center(
      child: Text('2. VISTA DE HISTORIAL Y GESTIÓN DE USUARIOS', style: TextStyle(fontSize: 24)),
    ),
    // 3. Generación de Contraseñas
    const Center(
      child: Text('3. VISTA DE GENERACIÓN DE CONTRASEÑAS', style: TextStyle(fontSize: 24)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Gestión de Citas'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Volver a la pantalla de login (simulación de cierre de sesión)
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      
      body: Row(
        children: [
          // 1. Menú Lateral (NavigationRail)
          NavigationRail(
            selectedIndex: _selectedIndex,
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.calendar_month),
                label: Text('Calendario'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history),
                label: Text('Historial'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_add),
                label: Text('Contraseñas'),
              ),
            ],
          ),
          
          const VerticalDivider(thickness: 1, width: 1),
          
          // 2. Contenido Principal: Muestra el widget seleccionado
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }
}