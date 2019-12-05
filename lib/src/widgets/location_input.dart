import 'package:app_lugares/src/helpers/location_helper.dart';
import 'package:app_lugares/src/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void showPreview(double lat, double lng){
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapUrl;
    });

  }

  Future<void> _getCurrentUserLocation() async{
    try {
      final locData = await Location().getLocation();
      showPreview(locData.latitude,locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);

    } catch (e) {
      return;
    }
  }

  Future<void> _onSelectMap() async{
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapPage(isSelecting: true,)
      )
    );
    if (selectedLocation == null) {
      return;
    }
    showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey)
          ),
          child: _previewImageUrl == null
                    ? Text('Ninguna ubicación seleccionada')
                    : Image.network(
                      _previewImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              onPressed: _getCurrentUserLocation,
              label: Text('Ubicación actual'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              onPressed: _onSelectMap,
              label: Text('Sel. en Mapa'),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}