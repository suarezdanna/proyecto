import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rolController = TextEditingController();

  //Nombre de la coleccion
  final CollectionReference _productss =
  FirebaseFirestore.instance.collection('Usuario');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';

    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['User'];
      _priceController.text = documentSnapshot['Pass'];
      _rolController.text = documentSnapshot['Rol'];
      print("hola");
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      contentPadding: const EdgeInsets.all(20),
                      fillColor: Colors.black,
                      hintText: "ID:",
                      hintStyle: TextStyle(color: Colors.black),
                    )),
                TextField(
                  controller: _rolController,
                  decoration: const InputDecoration(labelText: 'Rol'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = _nameController.text;
                    final String? rol = _rolController.text;
                    final double? price =
                    double.tryParse(_priceController.text);
                    if (name != null && price != null && rol != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _productss
                            .add({"User": name, "Pass": price, "Rol": rol});
                      }

                      if (action == 'update') {
                        // Update the product
                        await _productss
                            .doc(documentSnapshot!.id)
                            .update({"User": name, "Pass": price, "Rol": rol});
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _priceController.text = '';
                      _rolController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _productss.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Administrar usuarios'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time

      body: StreamBuilder(
        stream: _productss.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(6),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(documentSnapshot['User']),
                    subtitle: Text(documentSnapshot['Rol'].toString()),
                    trailing: SizedBox(
                      width: 200,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              color: Colors.black,
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.green,
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
/*
//main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Rest.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text fields' controllers

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rolController = TextEditingController();

  //Nombre de la coleccion
  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('Usuario');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    print("Hola mundo");
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['User'];
      _priceController.text = documentSnapshot['Pass'];
      _rolController.text = documentSnapshot['Rol'];

      print("Hola mundo");
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Usuario'),
                ),
                TextField(
                  controller: _rolController,
                  decoration: const InputDecoration(labelText: 'Rol'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = _nameController.text;
                    final String? rol = _rolController.text;
                    final double? price =
                        double.tryParse(_priceController.text);
                    if (name != null && price != null && rol != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _productss
                            .add({"User": name, "Pass": price, "Rol": rol});
                      }

                      if (action == 'update') {
                        // Update the product
                        await _productss
                            .doc(documentSnapshot!.id)
                            .update({"User": name, "Pass": price, "Rol": rol});
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _priceController.text = '';
                      _rolController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _productss.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Administrar usuarios'),
        backgroundColor: Colors.green,

      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _productss.snapshots(),

        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['User']),
                    subtitle: Text(documentSnapshot['Rol'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              color: Colors.black,
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }


}*/
