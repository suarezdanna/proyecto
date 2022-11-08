import 'package:flutter/material.dart';
import 'package:proyecto/main.dart';
import 'package:flutter/cupertino.dart';
import 'Rest.dart';

/*void main(){
  runApp(MaterialApp(
    routes: {
      '/Rest' : (context) => Rest(),
    },
  ));
}*/
class Soporte extends StatefulWidget {
  @override
  soporteT createState() => soporteT();
}

class soporteT extends State<Soporte> {
  //const soporteT({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tu Utiles Escolares "),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('Bienvenido'),
                accountEmail: Text('acb@gmail.com'),
              ),
              ListTile(
                title: Text('Servicio rest'),
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Rest()));
                },
              ),
              ListTile(
                title: Text('Tienda'),
                leading: Icon(Icons.shopping_cart_sharp),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Soporte()));
                },
              )
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: <Widget>[
            ListTile(
              leading: Image.asset('imgs/mnz.png'), // establecer imagen
              title: Text('Mochila',
                  style: TextStyle(
                      // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500)),
              subtitle: Text('Unidad -> 80.000'),
            ),
            Text('Cra 9#8-24'),
            ListTile(
              leading: Image.asset('imgs/mnz2.png'), // establecer imagen
              title: Text('Kit escolar 5 piezas con regla de 30 cm y compas',
                  style: TextStyle(
                      // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500)),
              subtitle: Text(' 8.000'),
            ),
            Text('Cra 9#8-24'),
            ListTile(
              leading: Image.asset('imgs/bna.png'), // establecer imagen
              title: Text('Set 36 marcadores punta fina',
                  style: TextStyle(
                      // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500)),
              subtitle: Text('84.500'),
            ),
            Text('Cra 9#8-24'),
            ListTile(
              leading: Image.asset('imgs/uva.png'), // establecer imagen
              title: Text('SUPER COMBO ESCOLAR INCLUYE:',
                  style: TextStyle(
                      // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500)),
              subtitle: Text('40.000'),
            ),
            Text('6 cuadernos cosidos de 100 hojas'),
            Text('Lapiz negro'),
            Text('Taja lapiz'),
            Text('Juego geometrico de reglas'),
            Text('Cra 9#8-24'),
            ListTile(
              leading: Image.asset('imgs/broco.png'), // establecer imagen
              title: Text('Tijeras',
                  style: TextStyle(
                      // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500)),
              subtitle: Text('Unidad -> 2.000'),
            ),
            Text('Cra 9#8-24'),
            ListTile(
              leading: Image.asset('imgs/fre.png'), // establecer imagen
              title: Text('Transportador',
                  style: TextStyle(
                      // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500)),
              subtitle: Text('Docena -> 5.000'),
            ),
            Text('Cra 9#8-24'),
            ListTile(
              leading: Image.asset('imgs/fre.png'), // establecer imagen
              title: Text('Resaltadores',
                  style: TextStyle(
                      // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500)),
              subtitle: Text('Docena -> 7.000'),
            ),
            Text('Cra 9#8-24'),
            ListTile(
              leading: Image.asset('imgs/fre.png'), // establecer imagen
              title: Text('Marcadores',
                  style: TextStyle(
                      // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500)),
              subtitle: Text('Docena -> 12.000'),
            ),
            Text('Cra 9#8-24'),
            ListTile(
              leading: Image.asset('imgs/fre.png'), // establecer imagen
              title: Text('Carpeta plastica',
                  style: TextStyle(
                      // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500)),
              subtitle: Text('Unidad -> 1.000'),
            ),
            Text('Cra 9#8-24'),
            ListTile(
              leading: Image.asset('imgs/fre.png'), // establecer imagen
              title: Text('Caja de colores',
                  style: TextStyle(
                      // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500)),
              subtitle: Text('Docena -> 11.000'),
            ),
            Text('Cra 9#8-24'),
            ListTile(
              leading: Image.asset('imgs/fre.png'), // establecer imagen
              title: Text('Esferos',
                  style: TextStyle(
                      // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500)),
              subtitle: Text('Unidad -> 2.000'),
            ),
            Text('Cra 9#8-24'),
          ],
        ),
        floatingActionButton: const FloatingActionButton(
          child: const Icon(Icons.shopping_cart_sharp),
          onPressed: null,
        ),
      ),
    );
  }
}
