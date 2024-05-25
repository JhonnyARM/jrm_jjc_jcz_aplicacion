import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// instancia de bd
FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> addColor(String color) async {
  DateTime now = DateTime.now();
  
  String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  
  await db.collection('color').add({
    "color": color,
    "timestamp": formattedDateTime, 
  });
}

// ========================================================== METODOS PARA USUARIOS =======
// FUNCION PARA OBTENER DATOS DE NUESTRA FIREBASE FIRESTORE
// Future es una promesa practicamente
// Future<TipoDatoDevolver> nombreMetodo() async{....}
Future<List> getPeople() async {
  List people = [];
  // el db.collection('nombre de coleccion en tu bd');
  /* CollectionReference collectionReferencePeople = db.collection('usuarios'); */

  // retorna toda la lista de la coleccion
  QuerySnapshot queryPeople = await db.collection('usuarios').get();
  // iteramos los documentos, cada vez que se haga una iteracion sera un documento diferente
  /* queryPeople.docs.forEach((documento) {
    // añadimos con people.add la informacion que contiene el documento
    people.add(documento.data());
  }); */
  for (var doc in queryPeople.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String,
        dynamic>; // la informacion de doc en query devuelve ahora un mapa
    final person = {
      "name": data['name'],
      "uid": doc.id,
    };
    people.add(person);
  }

  await Future.delayed(const Duration(seconds: 1));

  return people;
}

// Metodo para crear usuarios
Future<void> addPeople(String name) async {
  await db.collection("usuarios").add({"name": name});
}
// Metodo actualizar usuarios

Future<void> updatePeople(String uid, String newname) async {
  try {
    await db.collection("usuarios").doc(uid).set({"name": newname});
  } catch (e) {
    throw Exception(e);
  }
}

// Metodo para eliminar usuarios
Future<void> deletePeople(String uid) async {
  try {
    await db.collection("usuarios").doc(uid).delete();
  } catch (e) {
    throw Exception(e);
  }
}



/// METODO PARA CATEGORIAS

Future<List> getcategorias() async {
  List categoria = [];
  CollectionReference collectionReferenceCategoria =
      db.collection('categorias');

  QuerySnapshot queryCategorias = await collectionReferenceCategoria.get();

  for (var doc in queryCategorias.docs) {
    
    final Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
    final categ = {
      "nombre": data['nombre'],
      "uid": doc.id
    };
    
    categoria.add(categ);
  }

  return categoria;
}

Future<void> addCategorias(String nombre) async {
  await db.collection('categorias').add({"nombre": nombre});
}

Future<void> updateCategorias(String uid, String newNombre) async {
  await db.collection('categorias').doc(uid).set({"nombre": newNombre});
}

Future<void> deleteCategorias(String uid) async {
  await db.collection('categorias').doc(uid).delete();
}



/// METODO PARA PROVEEDORES

Future<List> getProveedor() async {
  List suma = [];
  CollectionReference collectionReferenceCategoria =
      db.collection('proveedor');

  QuerySnapshot queryCategorias = await collectionReferenceCategoria.get();

  for (var doc in queryCategorias.docs) {
    
    final Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
    final sum = {
      "calculo": data['calculo'],
      "fecha": data['fecha'],
      "uid": doc.id
    };
    
    suma.add(sum);
  }
  return suma;
}

Future<void> addProveedor(String nombre) async {
  await db.collection('proveedor').add({"nombre": nombre});
}

Future<void> updateProveedor(String uid, String newNombre) async {
  await db.collection('proveedor').doc(uid).set({"nombre": newNombre});
}

Future<void> deleteProveedor(String uid) async {
  await db.collection('proveedor').doc(uid).delete();
}

// METODO CALCULADORA
Future<List> getSuma() async {
  List categoria = [];
  CollectionReference collectionReferenceCategoria =
      db.collection('calculadora');

  QuerySnapshot queryCategorias = await collectionReferenceCategoria.get();

  for (var doc in queryCategorias.docs) {
    
    final Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
    final categ = {
      "calculo": data['calculo'],
      "fecha": data['fecha']
    };
    
    categoria.add(categ);
  }
  return categoria;
}
Future<void> addSuma(String date, double suma) async {
  await db.collection('calculadora').add({"fecha": date,"calculo":suma});
}



Future<void> addValuesRadio(String valor1,valor2) async {
  DateTime now = DateTime.now();
  
  String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  await db.collection('radio').add({
    "valor1": valor1,
    "valor2": valor2,
    "timestamp": formattedDateTime,
  });
}

Future<List<Map<String, dynamic>>> getRadioValues() async {
  List<Map<String, dynamic>> radioValues = [];
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('radio').get();
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      radioValues.add({
        "valor1": data['valor1'],
        "valor2": data['valor2'],
        "timestamp": data['timestamp'],
      });
    });
  } catch (e) {
    print("Error al obtener los valores de la colección 'radio': $e");
  }
  return radioValues;

}