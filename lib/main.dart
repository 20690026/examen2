import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Mini ONO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double size = 100.0;
  List<int> jugador1 = List<int>.generate(4, (index) => Random().nextInt(9) + 1);
  List<int> jugador2 = List<int>.generate(4, (index) => Random().nextInt(9) + 1);
  int contador=0;
  bool bandera = false;
  int limite=20;

  void mostrarMensaje(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mensaje'),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }


  BoxDecoration cajaRedonda(Color fondo) => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: fondo,
        border: Border.all(color: Colors.black87, width: 2),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text(contador.toString()),
       Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: jugador1.asMap().entries.map((entry) {
             int index = entry.key;
            int numero = entry.value;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Container(
                  decoration: cajaRedonda(Colors.blue),
                  height: size,
                  width: size,
                  child: Center(
                    child: Text(
                      numero.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                    
                  ),
                ),
                onTap: () {
                    setState(() {
                        contador += numero;
                        if(contador < limite){
                          jugador1[index] = Random().nextInt(9) + 1;
                          bandera= true;
                        } else if(contador>= limite){
                          mostrarMensaje("Ha perdido el jugador 1");
                          contador=0;
                        }

                  });
                  },
              ),
            );
          }).toList(),
        ),
               
               
               Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: jugador2.asMap().entries.map((entry) {
             int index = entry.key;
            int numero = entry.value;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: cajaRedonda(Colors.blue),
                  height: size,
                  width: size,
                  child: Center(
                    child: Text(
                      numero.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                
            );
          }).toList(),
        ),
        ],),
      
    );
  }
}