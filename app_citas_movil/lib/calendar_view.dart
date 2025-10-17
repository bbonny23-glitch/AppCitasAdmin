// Archivo: lib/calendar_view.dart
// Vista de gestión de citas del administrador.

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Librería popular para calendarios

// Modelo de datos simple para una cita
class Appointment {
  final String id;
  final String userName;
  final String service;
  final DateTime time;
  final bool isConfirmed;

  Appointment({
    required this.id,
    required this.userName,
    required this.service,
    required this.time,
    this.isConfirmed = false,
  });
}

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  // Estado para el calendario
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Lista simulada de citas (ESTO VENDRÍA DE FIRESTORE EN EL FUTURO)
  final List<Appointment> _appointments = [
    Appointment(
      id: 'A001',
      userName: 'Carlos Pérez',
      service: 'Corte de Cabello',
      time: DateTime.now().subtract(const Duration(hours: 1)),
      isConfirmed: true,
    ),
    Appointment(
      id: 'A002',
      userName: 'Laura Gómez',
      service: 'Consulta Médica',
      time: DateTime.now().add(const Duration(hours: 2)),
      isConfirmed: false,
    ),
    Appointment(
      id: 'A003',
      userName: 'Jorge Bonny',
      service: 'Sesión de Coaching',
      time: DateTime.now().add(const Duration(days: 1, hours: 10)),
      isConfirmed: true,
    ),
  ];
  
  // Función para obtener las citas del día seleccionado
  List<Appointment> _getAppointmentsForDay(DateTime day) {
    return _appointments.where((cita) => 
      cita.time.day == day.day &&
      cita.time.month == day.month &&
      cita.time.year == day.year
    ).toList();
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    // Las citas del día enfocado actualmente
    final citasDelDia = _getAppointmentsForDay(_selectedDay ?? _focusedDay);

    return Column(
      children: [
        // --- 1. CALENDARIO ---
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // Mantener el mes visible
            });
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        
        // --- 2. LISTA DE CITAS DEL DÍA SELECCIONADO ---
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Citas para: ${DateFormat('EEE, d MMM', 'es_MX').format(_selectedDay ?? _focusedDay)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        Expanded(
          child: citasDelDia.isEmpty
              ? const Center(child: Text('No hay citas para este día.'))
              : ListView.builder(
                  itemCount: citasDelDia.length,
                  itemBuilder: (context, index) {
                    final cita = citasDelDia[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      elevation: 2,
                      child: ListTile(
                        leading: Icon(
                          cita.isConfirmed ? Icons.check_circle : Icons.access_time,
                          color: cita.isConfirmed ? Colors.green : Colors.orange,
                        ),
                        title: Text('${cita.userName} - ${cita.service}'),
                        subtitle: Text(DateFormat('HH:mm a').format(cita.time)),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // Lógica de gestión: Confirmar/Cancelar
                            print('Gestionar cita ${cita.id}');
                          },
                          child: Text(cita.isConfirmed ? 'Gestionar' : 'Confirmar'),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}