// ignore_for_file: unnecessary_null_comparison
import 'dart:convert';
import 'dart:io';
import 'dart:async';

// Clase Magic que representa una carta de magia con varias propiedades
class Magic {
  final String name;
  String? description;
  String? image;
  String? apiname;
  String? type;
  String? rarity;
  String? setName;
  String? damage;
  String? health;
  double? levelMagic;
  int rating = 10;

  // Constructor de la clase que requiere el nombre de la carta como parámetro
  Magic(this.name);

  // Método asincrónico para obtener la URL de la imagen de la carta desde la API
  Future getImageUrl() async {
    // Si la imagen ya está definida, no se hace nada
    if (image != null) {
      return;
    }

    // Crear un cliente HTTP para realizar la solicitud
    HttpClient http = HttpClient();
    try {
      apiname = name.toLowerCase();
      // Define la URL de la API con los parámetros adecuados para la búsqueda
      var uri = Uri.https('api.magicthegathering.io','/v1/cards', {'name': apiname});
      // Realiza la solicitud GET a la API
      var request = await http.getUrl(uri);
      // Obtiene la respuesta de la API
      var response = await request.close();
      // Convierte la respuesta de la API en un String
      var responseBody = await response.transform(utf8.decoder).join();
      // Decodifica el JSON de la respuesta
      var data = json.decode(responseBody);
      // Extrae la lista de cartas de la respuesta
      List dataList = data["cards"];
      // Asigna los valores obtenidos de la API a los atributos de la clase
      description = dataList[0]["text"];
      image = dataList[0]["imageUrl"];
      rarity  = dataList[0]["rarity"];
      setName  = dataList[0]["setName"];
      damage  = dataList[0]["power"];
      health  = dataList[0]["toughness"];
      levelMagic = dataList[0]["cmc"];

    } catch (exception) {
      print(exception);
    }
  }
}
