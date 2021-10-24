import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:map_app/providers/great_places.dart';
import 'package:provider/provider.dart';
import '../helpers/db_helper.dart';
import '../models/place.dart';
import 'dart:io';


class AllMapScreen extends StatefulWidget {
  static const routeName = '/all-map';
  @override
  _AllMapScreenState createState() => _AllMapScreenState();
}

class _AllMapScreenState extends State<AllMapScreen> {

  Future<List<Place>> getPlace() async {
    final List<Map<String, dynamic>> dataList = await DBHelper.getData('user_places');
    return List.generate(dataList.length, (i) {
      return Place(
        id: dataList[i]['id'],
        title: dataList[i]['title'],
        image: File(dataList[i]['image']),
        location: PlaceLocation(
        latitude: dataList[i]['loc_lat'],
        longitude: dataList[i]['loc_lng'],
        address: dataList[i]['address'],
      )
      );
    });
  }

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final spots = await getPlace();
    setState(() {
      _markers.clear();
      for (final spot in spots) {
        final marker = Marker(
          markerId: MarkerId(spot.id as String),
          position: LatLng(spot.location!.latitude as double, spot.location!.longitude as double),
          infoWindow: InfoWindow(
            title: spot.title,
            snippet: spot.location!.address,
          ),
        );
        _markers[spot.id as String] = marker;
      }
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Map"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 11.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }


}