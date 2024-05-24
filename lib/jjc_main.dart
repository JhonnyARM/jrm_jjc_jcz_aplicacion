import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../img_slider.dart';
import '../switch_time_picker_view.dart';
import '../theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        '/switch-time-picker': (context) => SwitchTimePickerView(),
      },
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider de Imágenes Locales y Web'),
      ),
      body: Column(
        children: [
          Expanded(
            child: LocalImageSlider(),
          ),
          SizedBox(height: 20),
          Expanded(
            child: WebImageSlider(),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/switch-time-picker');
            },
            child: Text('Ir a Switch y TimePicker'),
          ),
        ],
      ),
    );
  }
}