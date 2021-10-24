import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/place_edit_screen.dart';
import './providers/great_places.dart';
import './screens/place_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/place_detail_screen.dart';
import './screens/all_map_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
          title: 'Great Places',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
          home: PlacesListScreen(),
          routes: {
            AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
            PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
            AllMapScreen.routeName: (ctx) => AllMapScreen(),
            EditPlaceScreen.routeName: (ctx) => EditPlaceScreen(),
          }),
    );
  }
}
