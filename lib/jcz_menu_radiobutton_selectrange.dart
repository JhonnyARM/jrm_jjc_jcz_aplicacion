import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'services/firebase_service.dart'; // Importa el servicio de Firebase

void main() {
  runApp(MaterialApp(
    title: 'RadioButton and Slider Example',
    home: RadioButtonSliderExample(),
  ));
}

class RadioButtonSliderExample extends StatefulWidget {
  @override
  _RadioButtonSliderExampleState createState() =>
      _RadioButtonSliderExampleState();
}

class _RadioButtonSliderExampleState extends State<RadioButtonSliderExample> {
  double _currentSliderValue = 25;
  List<double> _radioValues = [25, 50, 75, 100];
  double? _selectedRadioValue;

  // Función para mostrar el diálogo con los valores seleccionados
  void _showValuesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Valores Seleccionados'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Opción seleccionada: ${_selectedRadioValue ?? _currentSliderValue}'),
              Text('Valor del slider: $_currentSliderValue'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Llama a la función addValuesRadio con los valores seleccionados
                addValuesRadio(_selectedRadioValue.toString(), _currentSliderValue.toString());
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  // Función para navegar a la página de listado
  void _navigateToListPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RadioButton and Slider Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecciona una opción:',
              style: TextStyle(fontSize: 16),
            ),
            Column(
              children: _radioValues
                  .map((value) => ListTile(
                        title: Text('Opción $value'),
                        leading: Radio<double>(
                          value: value,
                          groupValue: _selectedRadioValue,
                          onChanged: (double? value) {
                            setState(() {
                              _selectedRadioValue = value;
                              _currentSliderValue = value!;
                            });
                          },
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Selecciona un rango:',
              style: TextStyle(fontSize: 16),
            ),
            Slider(
              value: _currentSliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showValuesDialog(context);
              },
              child: Text('Mostrar valores'),
            ),
            SizedBox(height: 10), // Agrega espacio entre los botones
            ElevatedButton(
              onPressed: () {
                _navigateToListPage(context); // Redirige a la página de listado
              },
              child: Text('Listar'),
            ),
          ],
        ),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Valores'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getRadioValues(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los datos'));
          } else {
            List<Map<String, dynamic>> data = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Valor 1')),
                  DataColumn(label: Text('Valor 2')),
                  DataColumn(label: Text('Fecha')),
                ],
                rows: data
                    .map(
                      (item) => DataRow(
                        cells: [
                          DataCell(Text(item['valor1'].toString())),
                          DataCell(Text(item['valor2'].toString())),
                          DataCell(Text(item['timestamp'].toString())),
                        ],
                      ),
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}