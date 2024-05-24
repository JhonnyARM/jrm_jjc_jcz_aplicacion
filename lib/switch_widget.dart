import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SwitchWidget extends StatefulWidget {
  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _isColorChanged = false;
  Color _newColor = const Color.fromARGB(255, 243, 135, 33); // Puedes cambiar este color por el que prefieras

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isColorChanged,
      onChanged: (value) {
        setState(() {
          _isColorChanged = value;
        });
        if (_isColorChanged) {
          context.read<ThemeProvider>().changeColor(_newColor);
        } else {
          context.read<ThemeProvider>().changeColor(Color.fromARGB(255, 224, 65, 2));
        }
      },
    );
  }
}