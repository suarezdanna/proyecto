import 'package:flutter/material.dart';
import "dart:async";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto/main.dart';

class Servicios extends StatefulWidget {
  @override
  Serviciosf createState() => Serviciosf();
}

class Serviciosf extends State<Servicios> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Administración"),
        ),
      ),
    );
  }
}
