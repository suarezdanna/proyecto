import "dart:async";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/Registro.dart';
import 'package:proyecto/main.dart';
import 'Inicio.dart';
import 'package:flutter/cupertino.dart';

class passRegister extends StatefulWidget {
  @override
  pasoPregistro createState() => pasoPregistro();
}

class pasoPregistro extends State<passRegister> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Gracias por registrarte"),
        ),
      ),
    );
  }
}
