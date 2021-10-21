import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _image = null;
  final ImagePicker _picker = ImagePicker();

   Future<void> _takePicture() async {
     final photo = await _picker.pickImage(
       source: ImageSource.camera,
       maxWidth: 600,
     );
     setState(() {
       if(photo != null) {
         _image = File(photo.path);
       }
     });

     final appDir = await syspaths.getApplicationDocumentsDirectory();
     final fileName = path.basename(_image!.path);
     final savedImage = await _image!.copy('${appDir.path}/$fileName');
     widget.onSelectImage(savedImage);
   }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color:Colors.grey),
            ),
          child: _image != null
              ? Image.file(
            _image!,
            fit: BoxFit.cover,
            width: double.infinity,
          )
              : Text(
            'No Image Taken',
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}