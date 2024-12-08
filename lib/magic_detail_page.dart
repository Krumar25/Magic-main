import 'package:flutter/material.dart';
import 'magic_model.dart';
import 'dart:async';

// Página de detalle de la carta que es un StatefulWidget
class MagicDetailPage extends StatefulWidget {
  final Magic magic; // Recibe la instancia de Magic a través del constructor
  const MagicDetailPage(this.magic, {super.key});

  @override
  // Método que crea el estado asociado a la página de detalle de la carta
  _MagicDetailPageState createState() => _MagicDetailPageState();
}

// Estado asociado a la página de detalle de la carta
class _MagicDetailPageState extends State<MagicDetailPage> {
  final double magicAvarterSize = 300.0; // Tamaño de la imagen de la carta
  double _sliderValue = 10.0; // Valor inicial del slider para la calificación

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.magic.rating.toDouble(); // Inicializa el valor del slider con la calificación actual de la carta
  }

  // Widget para mostrar un slider y permitir al usuario calificar la carta
  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: const Color(0xFF0B479E),
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue, // Establece el valor del slider
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating; // Actualiza el valor del slider en tiempo real
                    });
                  },
                ),
              ),
              // Muestra el valor actual de la calificación (como un texto)
              Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_sliderValue.toInt()}', // Muestra el valor entero del slider
                    style: const TextStyle(color: Colors.black, fontSize: 25.0),
                  )
              ),
            ],
          ),
        ),
        submitRatingButton, // Muestra el botón de envío de la calificación
      ],
    );
  }

  // Método para actualizar la calificación de la carta
  void updateRating() {
    // Si la calificación es menor a 5, muestra un error
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.magic.rating = _sliderValue.toInt(); // Actualiza la calificación de la carta
      });
    }
  }

  // Muestra un diálogo de error si la calificación es demasiado baja
  Future<void> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error!'),
            content: const Text("Come on! They're good!"),
            actions: <Widget>[
              TextButton(
                child: const Text('Try Again'),
                onPressed: () => Navigator.of(context).pop(), // Cierra el diálogo al presionar "Try Again"
              )
            ],
          );
        });
  }

  // Widget para mostrar el botón de envío de la calificación
  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(), // Llama al método para actualizar la calificación
      child: const Text('Submit'),
    );
  }

  // Widget para mostrar la imagen de la carta con un efecto Hero para la transición
  Widget get magicImage {
    return Hero(
      tag: widget.magic, // Establece el tag para la animación Hero
      child: GestureDetector(
        onTap: () => showZoomDialog(), // Llama al método para mostrar el zoom de la imagen
        child: Container(
          height: magicAvarterSize,
          width: magicAvarterSize,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(56.0),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(widget.magic.image ?? ""), // Muestra la imagen de la carta
            ),
          ),
        ),
      ),
    );
  }

  // Muestra un cuadro de diálogo para hacer zoom en la imagen de la carta
  void showZoomDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Fondo transparente para la imagen
          child: Hero(
            tag: widget.magic, // Establece el tag para la animación Hero
            child: Image.network(
              widget.magic.image ?? "", // Muestra la imagen ampliada
              fit: BoxFit.contain, // Ajusta la imagen al espacio sin recortarla
            ),
          ),
        );
      },
    );
  }

  // Widget para mostrar la calificación actual de la carta
  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.star,
          size: 40.0,
          color: Colors.yellowAccent, // Estrella amarilla para la calificación
        ),
        // Muestra la calificación actual en formato "rating/10"
        Text('${widget.magic.rating}/10', style: const TextStyle(color: Colors.black, fontSize: 30.0))
      ],
    );
  }

  // Widget para mostrar el perfil de la carta, incluyendo su imagen, nombre, descripción y calificación
  Widget get magicProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(
        color: Color(0xFFABCAED), // Fondo color azul claro para el perfil
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          magicImage, // Muestra la imagen de la carta
          Text(widget.magic.name, style: const TextStyle(color: Colors.black, fontSize: 32.0)), // Nombre de la carta
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0), // Padding alrededor del texto y la calificación
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea el contenido a la izquierda
              children: [
                Text(
                  '${widget.magic.description}',
                  style: const TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                const SizedBox(height: 8.0), // Espacio entre la descripción y la calificación
                rating, // Muestra la calificación de la carta
              ],
            ),
          )
        ],
      ),
    );
  }

  // Método que construye la UI de la página
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFABCAED), // Fondo color azul claro para toda la pantalla
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B479E), // Color del AppBar
        title: Text('Meet ${widget.magic.name}'), // Título con el nombre de la carta
      ),
      body: ListView(
        children: <Widget>[magicProfile, addYourRating], // Muestra el perfil de la carta y el slider para calificar
      ),
    );
  }
}