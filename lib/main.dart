import 'package:app_lugares/src/pages/add_place_page.dart';
import 'package:app_lugares/src/pages/place_detail_page.dart';
import 'package:app_lugares/src/pages/places_list_page.dart';
import 'package:app_lugares/src/providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mis Lugares',
        //ThemeData sirve para configurar algunas caracteristicas por defecto de la UI de nuestra app
        //como las fuentes(tipo, tamaños, color), colores de la aplicacion, de los botones, etc.
        theme: ThemeData(
          primarySwatch: Colors.indigo, // color primario
          accentColor: Colors.amber     // color secundario
        ),
        home: PlacesListPage(), //pagina inicial
        //rutas a las otras paginas
        routes: {
          AddPlacePage.routeName: (context) => AddPlacePage(),
          PlaceDetailPage.routeName: (context) => PlaceDetailPage()
        },
      ),
    );
  }
}