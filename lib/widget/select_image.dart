import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class SelectedImage extends StatefulWidget {
  final Function onSelectImage;
  SelectedImage(this.onSelectImage);

  @override
  _SelectedImageState createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {
  File? _image;

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('images/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  bool angry = false;
  bool li_angry = false;
  bool normal = false;
  bool li_happy = false;
  bool happy = false;



  Future<void> angryPicture() async { //怒り選択
    angry = true;
    li_angry = false;
    normal = false;
    li_happy = false;
    happy = false;

    File photo = await getImageFileFromAssets('angry.png');
    setState(() {
      if(photo != null) {
        _image = photo;
      }
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_image!.path);
    final savedImage = await _image!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  Future<void> li_angryPicture() async { //li-angry選択
    angry = false;
    li_angry = true;
    normal = false;
    li_happy = false;
    happy = false;

    File photo = await getImageFileFromAssets('li-angry.png');
    setState(() {
      if(photo != null) {
        _image = photo;
      }
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_image!.path);
    final savedImage = await _image!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  Future<void> normalPicture() async { //normal選択
    angry = false;
    li_angry = false;
    normal = true;
    li_happy = false;
    happy = false;

    File photo = await getImageFileFromAssets('normal.png');
    setState(() {
      if(photo != null) {
        _image = photo;
      }
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_image!.path);
    final savedImage = await _image!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  Future<void> li_happyPicture() async { //li-happy選択
    angry = false;
    li_angry = false;
    normal = false;
    li_happy = true;
    happy = false;

    File photo = await getImageFileFromAssets('li-happy.png');
    setState(() {
      if(photo != null) {
        _image = photo;
      }
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_image!.path);
    final savedImage = await _image!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  Future<void> happyPicture() async { //happy選択
    angry = false;
    li_angry = false;
    normal = false;
    li_happy = false;
    happy = true;

    File photo = await getImageFileFromAssets('happy.png');
    setState(() {
      if(photo != null) {
        _image = photo;
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: angryPicture,
          child: angry != false
            ? Container(
                child: Image.asset('images/angry.png'),
                width: 60.0,
                decoration: BoxDecoration(
                  color: Colors.blueAccent
                ),
              )
            : Container(
            child: Image.asset('images/angry.png'),
            width: 60.0,
            decoration: BoxDecoration(
                color: Colors.white
            ),
              )
        ),
        InkWell(
            onTap: li_angryPicture,
            child: li_angry != false
                ? Container(
              child: Image.asset('images/li-angry.png'),
              width: 60.0,
              decoration: BoxDecoration(
                  color: Colors.blueAccent
              ),
            )
                : Container(
              child: Image.asset('images/li-angry.png'),
              width: 60.0,
              decoration: BoxDecoration(
                  color: Colors.white
              ),
            )
        ),
        InkWell(
            onTap: normalPicture,
            child: normal != false
                ? Container(
              child: Image.asset('images/normal.png'),
              width: 60.0,
              decoration: BoxDecoration(
                  color: Colors.blueAccent
              ),
            )
                : Container(
              child: Image.asset('images/normal.png'),
              width: 60.0,
              decoration: BoxDecoration(
                  color: Colors.white
              ),
            )
        ),
        InkWell(
            onTap: li_happyPicture,
            child: li_happy != false
                ? Container(
              child: Image.asset('images/li-happy.png'),
              width: 60.0,
              decoration: BoxDecoration(
                  color: Colors.blueAccent
              ),
            )
                : Container(
              child: Image.asset('images/li-happy.png'),
              width: 60.0,
              decoration: BoxDecoration(
                  color: Colors.white
              ),
            )
        ),
        InkWell(
            onTap: happyPicture,
            child: happy != false
                ? Container(
              child: Image.asset('images/happy.png'),
              width: 60.0,
              decoration: BoxDecoration(
                  color: Colors.blueAccent
              ),
            )
                : Container(
              child: Image.asset('images/happy.png'),
              width: 60.0,
              decoration: BoxDecoration(
                  color: Colors.white
              ),
            )
        ),
      ],
    );
  }
}

