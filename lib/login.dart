import "dart:async";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Registro.dart';
import 'Rest.dart';
import 'package:proyecto/Soporte.dart';
import 'package:proyecto/main.dart';
import 'Inicio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'Rest.dart';
import 'Geolocalizacion.dart';
import 'gestionAdmin.dart';
import 'firebase_options.dart';

class login extends StatefulWidget {
  @override
  LoginApp createState() => LoginApp();
}

class LoginApp extends State<login> {
  TextEditingController User = TextEditingController();
  TextEditingController Password = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  String idUser = '';

  validarDatos() async {
    bool flag = false;
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection("Usuario");
      QuerySnapshot Usuario = await ref.get();

      if (Usuario.docs.length != 0) {
        for (var cursor in Usuario.docs) {
          //buscar datos en bd
          print("bdd");
          // mensaje('Usuario', cursor.get('User'));
          if (User.text == cursor.get('User')) {
            print("user");
            // mensaje('Mensaje', 'Dato encontrado');
            if (Password.text == cursor.get('password')) ;
            print("contra");
            idUser = cursor.id.toString();
            flag = true;
            if (cursor.get("Rol") == 'Admin') {
              print("Información");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              print("Pantalla de usuario");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Soporte()),
              );
            }

            print(cursor.id);
          }
        }
      }
      if (!flag) {
        mensajeG('Mensaje', 'dato no encontrado');
      }
    } catch (e) {
      mensajeG('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    /*setState(() {
      biometrico();
    });*/
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Inicio de sesión"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 68.8),
                child: Center(
                  child: Container(
                    width: 180,
                    height: 200,
                    child: Image.asset(
                      'imgs/bnd.png',
                      width: 240, //ancho
                      height: 100, //alto
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.8, top: 8, right: 15, bottom: 8),
                child: TextField(
                  controller: User,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'User',
                    hintText: 'Digite usuario',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.8, top: 8, right: 15, bottom: 8),
                child: TextField(
                  controller: Password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Password',
                    hintText: 'Digite contraseña',
                  ),
                ),
              ),
              Container(
                height: 50, //alto
                width: 240, //ancho
                decoration: BoxDecoration(
                    //boton de registro
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    await validarDatos(); //metodo para validar datos

                    /* Navigator.push(context,
                      MaterialPageRoute(builder: (_) =>
                          Inicio())); //paso para registrarse, hacer paso a nueva ventana*/
                  },
                  child: Text(
                    'Ingresar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              /* Container(
                height: 50, //alto
                width: 240, //ancho
                decoration: BoxDecoration(
                  //boton de registro
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Rest()));

  },
                  child: Text(
                    'Consumir servicio',
                    style: TextStyle(color: Colors.white, fontSize: 20),

                  ),
                ),
              ),*/
              /*   Container(
                height: 50, //alto
                width: 240, //ancho
                decoration: BoxDecoration(
                  //boton de registro
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    print('Geolocalización');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Geolocalizacion('')));
                  },
                  child: Text('Geolocalización',style: TextStyle(color: Colors.white,fontSize: 20)),
                ),
              ),*/

              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //boton huella
                    minimumSize: Size(50, 50),
                    primary: Colors.green,
                  ),
                  onPressed: () async {
                    print("dentro");
                    bool isSuccess = await biometrico();

                    print('success ' + isSuccess.toString());
                  },
                  child: Icon(Icons.fingerprint, size: 80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void mensaje(String titulo, String mess, String userId) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  String idU = await userId;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Geolocalizacion(idU)));
                },
                child:
                    Text("Aceptar", style: TextStyle(color: Colors.blueGrey)),
              )
            ],
          );
        });
  }

  void mensajeG(String titulo, String mess) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            //
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                    Text("Aceptar", style: TextStyle(color: Colors.blueGrey)),
              )
            ],
          );
        });
  }

  Future<bool> biometrico() async {
    //print("biométrico");

    bool flag = true;
    bool authenticated = false;
    if (flag) {
      const androidString = const AndroidAuthMessages(
        cancelButton: "Cancelar",
        goToSettingsButton: "Ajustes",
        signInTitle: "Ingrese",
        goToSettingsDescription: "Confirme su huella",
        biometricHint: "Toque el sensor",
        biometricNotRecognized: "Huella no reconocida",
        biometricRequiredTitle: "Required Title",
        biometricSuccess: "Huella reconocida",
      );
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isBiometricSupported = await auth.isDeviceSupported();
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      print(canCheckBiometrics); //Returns trueB
      print("support -->" + isBiometricSupported.toString());
      print(
          availableBiometrics.toString()); //Returns [BiometricType.fingerprint]
      try {
        authenticated = await auth.authenticate(
            localizedReason: "Autentíquese para acceder",
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
            androidAuthStrings: androidString);
        if (!authenticated) {
          authenticated = false;
        }
      } on PlatformException catch (e) {
        print(e);
      }
      /* if (!mounted) {
        return;
      }*/

    }
    return authenticated;
  }
}
