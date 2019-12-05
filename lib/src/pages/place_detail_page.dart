import 'package:app_lugares/src/models/place.dart';
import 'package:app_lugares/src/providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'map_page.dart';

class PlaceDetailPage extends StatelessWidget {
  static const routeName = 'place-detail';
  //ruta que lleva a esta pagina/pantalla

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context).settings.arguments;
    Place place =
        Provider.of<GreatPlaces>(context, listen: false).findById(placeId);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 4,
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.1, color: Colors.grey)),
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            child: Text(
              place.location.address,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton.icon(
            icon: Icon(Icons.location_on),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapPage(
                        initialLocation: place.location,
                      )));
            },
            label: Text('Ver en mapa'),
            textColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
