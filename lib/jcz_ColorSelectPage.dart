import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'services/firebase_service.dart'; // Importa el servicio de Firebase

class ColorSelectPage extends StatefulWidget {
  const ColorSelectPage({Key? key}) : super(key: key);

  @override
  _ColorSelectPageState createState() => _ColorSelectPageState();
}

class _ColorSelectPageState extends State<ColorSelectPage> {
  Color _selectedColor = Colors.white;

  Widget buildColorButton(Color color, String colorName) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            // Actualiza el color seleccionado al hacer clic en el botón
            _selectedColor = color;
          });
          addColor(colorName); // Llama a la función addColor con el nombre del color
        },
        child: Text('Enviar $colorName'), // Muestra el nombre del color en el botón
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cambio de Colores', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 28),
            Container(
              color: Colors.yellow,
              padding: EdgeInsets.all(0),
              child: Text(
                'Opciones de Colores',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            SizedBox(height: 0),
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  RadioListTile<Color>(
                    title: Text('Amarillo'),
                    value: Colors.yellow,
                    groupValue: _selectedColor,
                    onChanged: (color) {
                      setState(() {
                        _selectedColor = color!;
                      });
                    },
                  ),
                  RadioListTile<Color>(
                    title: Text('Rojo'),
                    value: Colors.red,
                    groupValue: _selectedColor,
                    onChanged: (color) {
                      setState(() {
                        _selectedColor = color!;
                      });
                    },
                  ),
                  RadioListTile<Color>(
                    title: Text('Verde'),
                    value: Colors.green,
                    groupValue: _selectedColor,
                    onChanged: (color) {
                      setState(() {
                        _selectedColor = color!;
                      });
                    },
                  ),
                  RadioListTile<Color>(
                    title: Text('Negro'),
                    value: Colors.black,
                    groupValue: _selectedColor,
                    onChanged: (color) {
                      setState(() {
                        _selectedColor = color!;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 0),
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(0),
              child: Column(
                children: [
                  SizedBox(height: 0),
                  Container(
                    width: 100,
                    height: 100,
                    color: _selectedColor,
                    alignment: Alignment.center,
                  ),
                  buildColorButton(_selectedColor, getColorName(_selectedColor)), // Agregar el botón dentro del método buildColorButton()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getColorName(Color color) {
    // Mapa de colores y sus nombres asociados
    Map<Color, String> colorNames = {
      Colors.yellow: 'Amarillo',
      Colors.red: 'Rojo',
      Colors.green: 'Verde',
      Colors.black: 'Negro',
    };
    return colorNames[color] ?? 'Desconocido'; // Devuelve el nombre del color o 'Desconocido' si no se encuentra
  }
}

void main() {
  runApp(ColorSelectPage());
}
