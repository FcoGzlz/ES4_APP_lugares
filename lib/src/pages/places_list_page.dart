import 'package:app_lugares/src/pages/add_place_page.dart';
import 'package:app_lugares/src/pages/place_detail_page.dart';
import 'package:app_lugares/src/providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Lugares'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacePage.routeName);
            },
          ),
        ],
      ),
      //el consumer es quien consume la data que tiene el provider
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child:
                      Text('No existen lugares, comienza a agregar algunos!'),
                ),
                builder: (context, greatPlaces, ch) =>
                    greatPlaces.items.length <= 0
                        ? ch
                        : 
                          ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (context, i) => Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                Provider.of<GreatPlaces>(context, listen: false)
                                    .deleteId(greatPlaces.items[i].id);
                              },

                              
                              background: Container(
                                margin: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                                alignment: AlignmentDirectional.centerEnd,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    stops: [0.6,9],
                                    colors: [Colors.red[200], Colors.red],
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                                  child: Icon(Icons.delete,
                                  color: Colors.white,
                                  ),
                                ),
                                
                              ),
                              direction: DismissDirection.endToStart,
                              
                              
                              
                              child: Container(

                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45.0) , topLeft: Radius.circular(45.0)),
                                    
                                  ),
                                  elevation: 8,
                                  child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[i].image),
                                ),
                                title: Text(greatPlaces.items[i].title),
                                subtitle:
                                    Text(greatPlaces.items[i].location.address),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlaceDetailPage.routeName,
                                      arguments: greatPlaces.items[i].id);
                                },
                              ),

                                ),
                                
                              ),
                              
                              
                              



                            ),
                          ),
                     
                      
              ),
      ),
    );
  }
}
