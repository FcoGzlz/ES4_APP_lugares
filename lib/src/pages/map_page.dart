import 'package:app_lugares/src/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  MapPage({this.initialLocation = const PlaceLocation(latitude: -45.577, longitude: -72.061), this.isSelecting = false}); 
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position){
    setState(() {
      _pickedLocation = position; 
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tu mapa'),
        actions: <Widget>[
          if(widget.isSelecting) IconButton(
            icon: Icon(Icons.check),
            onPressed: _pickedLocation == null ? null : (){
              Navigator.of(context).pop(_pickedLocation);
            },
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude
          ),
          zoom: 16,
        ),
        onTap:  widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting) ? null : {
          Marker(
            markerId: MarkerId('m1'),
            position: _pickedLocation ?? LatLng(
              widget.initialLocation.latitude, 
              widget.initialLocation.longitude
            )
          ),
        },
      ),
    );
  }
}