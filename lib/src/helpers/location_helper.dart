import 'dart:convert';
import 'package:http/http.dart' as http;//plugin que permite hacer consultas a una API REST

//API KEY global para acceder a las diferentes API's que tiene google
const GOOGLE_API_KEY = 'AIzaSyB8pPPq2PwwamuRiRGV8ziacwlnmdmdDDc';

class LocationHelper {
  //este metodo solo retorna la url del mapa de google
  //con ciertos parametros que uno puede especificar
  //como por ejemplo la latitud y longitud y la API KEY
  //notar como se pasan esas variables a la ruta y a que corresponde
  //cada parametro
  static String generateLocationPreviewImage({double latitude, double longitude,}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  //este metodo me retorna la direccion "valida" en base a una latitud y longitud
  //como por ejemplo: "Jose Pomar 171, Coyhaique".
  static Future<String> getPlaceAddress(double lat, double lng) async {
    //esta url retorna un json con varios datos
    //se puede probar en el navegador cambiando los valores de lat y lng con unos validos
    //ademas de colocar la api key
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    //se usa http para realizar la consulta a la API
    final response = await http.get(url);
    //decodifica la respuesta y accede al parametro que necesitamos
    //que en este caso es la "direccion formateada", formatted_address
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}