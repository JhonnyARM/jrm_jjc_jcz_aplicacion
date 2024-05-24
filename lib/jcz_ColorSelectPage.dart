import 'package:flutter/material.dart';

class ColorSelectPage extends StatefulWidget {
  const ColorSelectPage({Key? key}) : super(key: key);

  @override
  _ColorSelectPageState createState() => _ColorSelectPageState();
}

class _ColorSelectPageState extends State<ColorSelectPage> {
  Color _selectedColor = Colors.white;

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
              padding: EdgeInsets.all(10),
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
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 0),
                  Container(
                    width: 100,
                    height: 100,
                    color: _selectedColor,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(ColorSelectPage());
}
