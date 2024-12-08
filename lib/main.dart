import 'package:flutter/material.dart';
import 'dart:async';
import 'magic_model.dart';
import 'magic_list.dart';
import 'new_magic_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic cards', // Título de la aplicación.
      theme: ThemeData(brightness: Brightness.dark), // Tema oscuro para la aplicación.
      home: const MyHomePage( // Establece la pantalla de inicio.
        title: 'My fav Magic cards',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState(); // Crea el estado de la página.
}

class _MyHomePageState extends State<MyHomePage> {
  List<Magic> initialMagics = [Magic('Ancestor\'s Chosen'), Magic('Angel of Mercy'), Magic('Angelic Blessing')];

  Future _showNewMagicForm() async {
    // Método para abrir el formulario de agregar nueva carta.
    Magic newMagic = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddMagicFormPage(); // Navega al formulario.
    }));
    initialMagics.add(newMagic); // Agrega la nueva carta a la lista.
    setState(() {}); // Actualiza la UI después de agregar la carta.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Muestra el título de la página.
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add), // Botón para agregar una nueva carta.
            onPressed: _showNewMagicForm, // Llama al método para mostrar el formulario.
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 88, 111, 137), // Fondo de la página.
        child: MagicList(initialMagics), // Muestra la lista de cartas mágicas.
      ),
    );
  }
}