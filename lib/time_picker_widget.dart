import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        TimeOfDay? newTime = await showTimePicker(
          context: context,
          initialTime: _selectedTime,
        );
        if (newTime != null) {
          setState(() {
            _selectedTime = newTime;
          });
          // Aquí puedes implementar la lógica para programar la alarma o recordatorio
          scheduleAlarm(_selectedTime);
        }
      },
      child: Text('Seleccionar hora de alarma: ${_selectedTime.format(context)}'),
    );
  }

  void scheduleAlarm(TimeOfDay time) {
    // Aquí puedes implementar la lógica para programar la alarma o recordatorio
    // Puedes utilizar paquetes como flutter_local_notifications o realizar alguna otra acción
  }
}