import 'package:flutter/material.dart';
import 'package:proyecto/Geolocalizacion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Registro.dart';
import 'login.dart';

//flutter upgrade --force

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: clase());
  }
}

class clase extends StatefulWidget {
  @override
  layout createState() => layout();
}

class layout extends State<clase> {
  // const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'AGRISTORE.SAS',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'AgriStore es una empresa que se dedica a la distribución de frutas y verduras,'
                  ' en el municipio de ubaté, principalmente de la plaza de mercado.'
                  ' ',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.yellow[500],
          ),
          const Text('41'),
        ],
      ),
    );
    Color color = Theme.of(context).primaryColorDark;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              print("Inicio de sesión");
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => login()));
            },
            icon: Icon(Icons.account_circle)),
        IconButton(
            onPressed: () {
              print("Registrarse");
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Registro()));
            },
            icon: Icon(Icons.app_registration)),
        IconButton(
            onPressed: () {
              print("Información");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Geolocalizacion('')),
              );
            },
            icon: Icon(Icons.location_on))
      ],
    );

    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        'El municipio de ubaté es reconocido por ser un sector agricola y lechero,'
        ' de esta manera AgriStore brinda un servicio de domicilios a la puerta de su casa.'
        ' para poder adquirir el servicio es necesario registrarse para proteger sus datos, '
        'tambien puede compartir esta información con sus conocidos, ¡HAGAMOS DE AGRISTORE NUESTRO HOGAR.',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: '¡Bienvenido AgriStore lo espera!',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('¡BIENVENIDO!'),
        ),
        body: ListView(
          children: [
            Image.asset(
              'imgs/AgriStore.png',
              width: 200,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
        //home: LoginStart
      ),
      // debugShowCheckedModeBanner: false,               ***************
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: color),
          ),
        ),
      ],
    );
  }
}

/*********************Segundo layout************************************/
//login.dart
/************************************************Tercer layout**********************/
//Soporte.dart
/************************************Cuarto layout*******************************/
class ShareCom extends StatelessWidget {
  const ShareCom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Páginas oficiales de AgriStore"),
        ),
      ),
    );
  }
}

/****************************************+***********************************/