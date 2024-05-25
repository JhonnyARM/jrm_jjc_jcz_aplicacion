import 'package:flutter/material.dart';
import 'package:jrm_jjc_jcz_aplicacion/services/firebase_service.dart';

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();

  double _result = 0.0;

  void _calculateSum() {
    final double num1 = double.tryParse(_controller1.text) ?? 0.0;
    final double num2 = double.tryParse(_controller2.text) ?? 0.0;
    final double num3 = double.tryParse(_controller3.text) ?? 0.0;
    final double num4 = double.tryParse(_controller4.text) ?? 0.0;
    DateTime fechaActual = DateTime.now();
    String fechaString =
        "${fechaActual.day}/${fechaActual.month}/${fechaActual.year}";

    _result = num1 + num2 + num3 + num4;
    addSuma(fechaString, _result);
    setState(() {
      _result = _result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suma de números'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.yellow,
              child: Text(
                'Operaciones',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Dato 1'),
            ),
            TextField(
              controller: _controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Dato 2'),
            ),
            TextField(
              controller: _controller3,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Dato 3'),
            ),
            TextField(
              controller: _controller4,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Dato 4'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _calculateSum,
                  child: Text('Calcular'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.yellow,
                  ),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => ListCalc())));
                }, child: Text("Ver"))
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.blue,
              child: Text(
                'Respuesta: $_result',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListCalc extends StatefulWidget {
  const ListCalc({super.key});

  @override
  State<ListCalc> createState() => _ListCalcState();
}

class _ListCalcState extends State<ListCalc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sumas'),
      ),
      body: FutureBuilder(
        future: getSuma(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras se espera la data
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Muestra un mensaje de error si ocurre un error al obtener la data
            return Center(
              child: Text(
                "Error al cargar los datos",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            // Lista los elementos del snapshot
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // Obtén el dato actual del snapshot
                var suma = snapshot.data![index];
                return ListTile(
                  title: Text("Resultado : " + suma['calculo'].toString() +" | Fecha "+ suma['fecha']),
                  // Agrega funcionalidad al presionar un elemento de la lista
                  onTap: () {
                    // Agrega aquí la lógica que desees al presionar un elemento
                    // Por ejemplo, actualización de UI o navegación a otra pantalla
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

