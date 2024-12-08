import 'package:digimon/magic_model.dart';
import 'magic_detail_page.dart';
import 'package:flutter/material.dart';

class MagicCard extends StatefulWidget {
  final Magic magic; // Objeto Magic que contiene los datos de la carta

  const MagicCard(this.magic, {super.key});

  @override
  // Método que crea el estado de la tarjeta de carta
  _MagicCardState createState() => _MagicCardState(magic);
}
class _MagicCardState extends State<MagicCard> {
  Magic magic; // Instancia de la carta
  String? renderUrl; // URL de la imagen de la carta

  // Constructor del estado que recibe la carta
  _MagicCardState(this.magic);

  @override
  void initState() {
    super.initState();
    renderMagicPic(); // Cargar la imagen de la carta al inicializar
  }
  // Widget que devuelve la imagen de la carta o un placeholder mientras carga
  Widget get magicImage {
    var magicAvatar = Hero(
      tag: magic, // Utiliza un Hero widget para la transición de la imagen
      child: Container(
        width: 223.0,
        height: 310.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(renderUrl ?? '')
          ),
        ),
      ),
    );
    var placeholder = Container(
      width: 223.0,
      height: 310.0,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black54, Colors.black, Color.fromARGB(255, 84, 110, 122)]
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        'DIGI',
        textAlign: TextAlign.center,
      ),
    );
    // Utiliza AnimatedCrossFade para animar el cambio entre el placeholder y la imagen real
    var crossFade = AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: magicAvatar,
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1000),
    );
    return crossFade;
  }

  // Función que obtiene la URL de la imagen de la carta
  void renderMagicPic() async {
    await magic.getImageUrl(); // Obtiene la URL de la imagen
    if (mounted) { // Verifica si el widget sigue en la pantalla antes de actualizar el estado
      setState(() {
        renderUrl = magic.image; // Actualiza la URL de la imagen
      });
    }
  }
  // Widget que crea la tarjeta con la información de la carta
  Widget get magicCard {
    return Positioned(
      right: 0.0,
      child: SizedBox(
        width: 360,
        height: 325,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: const Color(0xFFF8F8F8),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 230),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Muestra el nombre de la carta
                Text(
                  widget.magic.name,
                  style: const TextStyle(color: Color(0xFF000600), fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                // Muestra la edición de la carta
                Text(
                  ('Edition: ${widget.magic.setName}'),
                  style: const TextStyle(color: Color(0xFF000600), fontSize: 12.0),
                ),
                SizedBox(height: 16.0),
                // Muestra la rareza de la carta
                Text(
                  ('Rarity: ${widget.magic.rarity}'),
                  style: const TextStyle(color: Color(0xFF000600), fontSize: 12.0),
                ),
                SizedBox(height: 16.0),
                // Muestra el daño de la carta
                Text(
                  ('Damage: ${widget.magic.damage}'),
                  style: const TextStyle(color: Color(0xFF000600), fontSize: 12.0),
                ),
                SizedBox(height: 16.0),
                // Muestra la salud de la carta
                Text(
                  ('Health: ${widget.magic.health}'),
                  style: const TextStyle(color: Color(0xFF000600), fontSize: 12.0),
                ),
                SizedBox(height: 16.0),
                // Muestra el costo de maná de la carta
                Text(
                  ('Mana cost: ${widget.magic.levelMagic}'),
                  style: const TextStyle(color: Color(0xFF000600), fontSize: 12.0),
                ),
                SizedBox(height: 16.0),
                // Muestra la calificación de la carta
                Row(
                  children: <Widget>[
                    const Icon(Icons.star, color: Colors.yellowAccent),
                    Text(': ${widget.magic.rating}/10', style: const TextStyle(color: Color(0xFF000600), fontSize: 14.0))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Función que navega a la página de detalles de la carta
  showMagicDetailPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MagicDetailPage(magic))) // Navega a la página de detalles
        .then((_) {
      setState(() {
        // Se actualiza el estado después de regresar de la página de detalles
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // Construcción del widget principal que contiene la tarjeta y la imagen
    return InkWell(
      onTap: () => showMagicDetailPage(), // Acción al tocar la tarjeta
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 330.0,
          child: Stack(
            children: <Widget>[
              magicCard, // La tarjeta con la información de la carta
              Positioned(top: 7.5, child: magicImage), // La imagen de la carta
            ],
          ),
        ),
      ),
    );
  }
}