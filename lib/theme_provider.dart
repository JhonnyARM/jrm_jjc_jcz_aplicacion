import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color _appColor = Color.fromARGB(255, 151, 3, 3); // Color inicial de la aplicación

  Color get appColor => _appColor;

  void changeColor(Color newColor) {
    _appColor = newColor;
    notifyListeners(); // Notifica a los widgets que escuchan los cambios de color
  }
}