import 'package:digimon/magic_model.dart';
import 'package:flutter/material.dart';


class AddMagicFormPage extends StatefulWidget {
  const AddMagicFormPage({super.key});

  @override
  // Crea el estado para la página de formulario de nueva carta.
  _AddMagicFormPageState createState() => _AddMagicFormPageState();
}

class _AddMagicFormPageState extends State<AddMagicFormPage> {
  TextEditingController nameController = TextEditingController(); // Controlador para el campo de texto del nombre de la carta.

  // Método para manejar el envío del formulario.
  void submitPup(BuildContext context) {
    // Verifica si el campo de nombre está vacío.
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the magic name'), // Muestra un mensaje de advertencia si el nombre está vacío.
      ));
    } else {
      var newMagic = Magic(nameController.text); // Crea una nueva carta mágica con el nombre ingresado.
      Navigator.of(context).pop(newMagic); // Vuelve a la página anterior pasando la nueva carta.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new magic'), // Título de la página.
        backgroundColor: const Color(0xFF0B479E), // Color de fondo de la barra de la aplicación.
      ),
      body: Container(
        color: const Color(0xFFABCAED), // Fondo del cuerpo de la página.
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: nameController, // Asocia el controlador al campo de texto.
                  style: const TextStyle(decoration: TextDecoration.none),
                  onChanged: (v) => nameController.text = v, // Actualiza el texto del controlador cuando cambia.
                  decoration: const InputDecoration(
                    labelText: 'Magic Name',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () => submitPup(context), // Llama al método submitPup cuando se presiona el botón.
                      child: const Text('Submit Magic'),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}