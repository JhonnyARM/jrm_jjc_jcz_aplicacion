import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jrm_jjc_jcz_aplicacion/services/firebase_service.dart';


class primero extends StatefulWidget {
  @override
  _primeroState createState() => _primeroState();
}

class _primeroState extends State<primero> {
  bool _isDarkMode = false;
  bool _isLargeText = false;
  List<String> _selectedChips = [];
  DateTime? _selectedDate;

  final List<Map<String, dynamic>> _items = [
    // GENOVESA
    {'name': 'Cordero', 'category': 'Carnes', 'darkMode': true, 'largeText': false},
    {'name': 'Res', 'category': 'Carnes', 'darkMode': true, 'largeText': false},
    {'name': 'Pavo', 'category': 'Carnes', 'darkMode': true, 'largeText': false},
    {'name': 'Pato', 'category': 'Carnes', 'darkMode': true, 'largeText': false},
    {'name': 'Queso', 'category': 'Lacteos', 'darkMode': true, 'largeText': false},
    {'name': 'Yogurt', 'category': 'Lacteos', 'darkMode': true, 'largeText': false},
    // PLAZA VEA
    {'name': 'Codorniz', 'category': 'Carnes', 'darkMode': false, 'largeText': true},
    {'name': 'Pollo', 'category': 'Carnes', 'darkMode': false, 'largeText': true},
    {'name': 'Ganzo', 'category': 'Carnes', 'darkMode': false, 'largeText': true},
    {'name': 'Mantequilla', 'category': 'Lacteos', 'darkMode': false, 'largeText': true},
    {'name': 'Leche', 'category': 'Lacteos', 'darkMode': false, 'largeText': true},
  ];

  final List<Map<String, dynamic>> _savedLists = [];

  List<Map<String, dynamic>> get _filteredItems {
    return _items.where((item) {
      if (_isDarkMode && !item['darkMode']) return false;
      if (_isLargeText && !item['largeText']) return false;
      if (_selectedChips.isNotEmpty && !_selectedChips.contains(item['category'])) return false;
      return true;
    }).toList();
  }
  // funcion para guardar lista
  void _saveList() {
    if (_selectedDate != null) {
      _savedLists.add({
        'date': _selectedDate,
        'items': _filteredItems,
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedListsPage(savedLists: _savedLists)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Proveedor', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            CheckboxListTile(
              title: Text('Genovesa'),
              value: _isDarkMode,
              onChanged: (bool? value) {
                setState(() {
                  _isDarkMode = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('PlazaVea'),
              value: _isLargeText,
              onChanged: (bool? value) {
                setState(() {
                  _isLargeText = value ?? false;
                });
              },
            ),
            SizedBox(height: 5),
            Text('Categoria de producto', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: [
                FilterChip(
                  label: Text('Carnes'),
                  selected: _selectedChips.contains('Carnes'),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedChips.add('Carnes');
                      } else {
                        _selectedChips.removeWhere((String name) {
                          return name == 'Carnes';
                        });
                      }
                    });
                  },
                ),
                FilterChip(
                  label: Text('Lacteos'),
                  selected: _selectedChips.contains('Lacteos'),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedChips.add('Lacteos');
                      } else {
                        _selectedChips.removeWhere((String name) {
                          return name == 'Lacteos';
                        });
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Fecha', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text(
                  _selectedDate == null ? 'Seleccionar fecha!' : DateFormat.yMMMd().format(_selectedDate!),
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text('Date'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _saveList,
                  child: Text('Guardar lista'),
                ),
                ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SavedListsPage(savedLists: _savedLists)),
                );
              },
              child: Text('Ver listas guardadas'),
            ),
              ],
            ),
            SizedBox(height: 20),
            Text('Lista', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text(item['category']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}

class SavedListsPage extends StatelessWidget {
  final List<Map<String, dynamic>> savedLists;

  const SavedListsPage({Key? key, required this.savedLists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas Guardadas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: savedLists.length,
          itemBuilder: (context, index) {
            final savedList = savedLists[index];
            final date = savedList['date'] as DateTime?;
            final items = savedList['items'] as List<Map<String, dynamic>>;

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date == null ? 'No date' : DateFormat.yMMMd().format(date),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...items.map((item) => Text('${item['name']} - ${item['category']}')).toList(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
