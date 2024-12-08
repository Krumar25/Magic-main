import 'package:digimon/magic_card.dart';
import 'package:flutter/material.dart'; 
import 'magic_model.dart'; 

// StatelessWidget que recibe una lista de objetos Magic
class MagicList extends StatelessWidget {
  final List<Magic> magics; // Lista de objetos Magic que se pasa al constructor
  const MagicList(this.magics, {super.key}); // Constructor que toma la lista de cartas

  @override
  Widget build(BuildContext context) {
    // Llama al método _buildList para construir la lista de cartas
    return _buildList(context);
  }

  // Método que construye la lista de elementos MagicCard
  ListView _buildList(context) {
    // Usamos ListView.builder para crear una lista dinámica de tarjetas
    return ListView.builder(
      itemCount: magics.length, // Número total de elementos en la lista (basado en el tamaño de la lista magics)
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        // Construye un widget MagicCard para cada elemento de la lista
        return MagicCard(magics[int]); // Pasa cada objeto Magic a MagicCard para mostrarlo
      },
    );
  }
}