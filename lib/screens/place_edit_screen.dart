import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import '../widget/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../widget/location_input.dart';
import '../models/place.dart';
import '../widget/select_image.dart';

class EditPlaceScreen extends StatefulWidget {
  static const routeName = '/edit-place';


  @override
  _EditPlaceScreenState createState() => _EditPlaceScreenState();
}

class _EditPlaceScreenState extends State<EditPlaceScreen> {



  final _titleController = TextEditingController();


  File? _pickedImage;
  PlaceLocation? _pickedLocation;


  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _editPlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // final id = ModalRoute.of(context)!.settings.arguments;
    // final selectedPlace = Provider.of<GreatPlaces>(context, listen: false).findById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: _titleController,
                    ),
                    SizedBox(height: 20),
                    SelectedImage(_selectedImage),
                    SizedBox(height: 20),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Complete Edit'),
            onPressed: _editPlace,
          ),
        ],
      ),
    );
  }
}