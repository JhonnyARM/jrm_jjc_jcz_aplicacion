import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }

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
          ],
        );
      },
    );
  }
}
