import 'package:flutter/material.dart';
import 'package:jrm_jjc_jcz_aplicacion/jcz_ColorSelectPage.dart';
import 'package:jrm_jjc_jcz_aplicacion/jcz_menu_radiobutton_selectrange.dart';
import 'package:jrm_jjc_jcz_aplicacion/jjc_main.dart';
import 'package:jrm_jjc_jcz_aplicacion/jrm_ejercicio1_calc.dart';
import 'package:jrm_jjc_jcz_aplicacion/jrm_ejercicio4_prod.dart';
import 'package:jrm_jjc_jcz_aplicacion/switch_time_picker_view.dart';
import 'package:provider/provider.dart';
import '../img_slider.dart';
import '../switch_time_picker_view.dart';
import '../theme_provider.dart';

void main() {
  runApp(/* const Home() */
  ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Home(),
    ),);
}

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Menu(),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calculadora()),
                );
              },
              child: Text('Calculadora'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ColorSelectPage()),
                );
              },
              child: Text('Cambio de colores'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text('Galeria'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => primero()),
                );
              },
              child: Text('Checkbox|Chip|Datepicker'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RadioButtonSliderExample()),
                );
              },
              child: Text('Menu|Radio|Slider'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SwitchTimePickerView()),
                );
              },
              child: Text('Switch|TimePicker'),
            ),
          ],
        ),
      ),
    );
  }
}
