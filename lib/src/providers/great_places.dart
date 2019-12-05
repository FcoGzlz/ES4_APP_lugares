import 'dart:io';
import 'package:app_lugares/src/helpers/db_helper.dart';
import 'package:app_lugares/src/helpers/location_helper.dart';
import 'package:app_lugares/src/models/place.dart';
import 'package:flutter/foundation.dart';

class GreatPlaces with ChangeNotifier{
  List<Place> _items = [];


  List<Place> get items{
    return [..._items];//spread operator
  }
    Place fineById(String id){
      return _items.firstWhere((place) => place.id == id);
    }
  Future<void> addPlace(String pickedTitle, File pickedImage, PlaceLocation pickedLocation) async{
    final address =   await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id' : newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address 
    });
    print('AGREGADO EN BD');
  }

  Future<void> fetchAndSetPlaces() async{
    final dataList = await DBHelper.getData('user_places');
    _items = dataList.map( (item) => Place(
      id: item['id'],
      title: item['title'],
      image: File(item['image']),
      location: PlaceLocation(
        latitude: item['loc_lat'],
        longitude: item['loc_lng'],
        address: item['address']
      )
    )).toList();
    print(dataList);
    notifyListeners();
  
  }
   
Future<void> deleteId(String id) async{
 final deletePlace = this.fineById(id);
 _items.remove(deletePlace);
 DBHelper.delete(id);
 notifyListeners();
}

Place findById(String id){
    return _items.firstWhere((place) => place.id == id);
}
}

  


















