import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UbahFoto extends StatefulWidget {
  final String idUserFoto;
  UbahFoto({this.idUserFoto});

  @override
  _UbahFotoState createState() => _UbahFotoState();
}

class _UbahFotoState extends State<UbahFoto> {
  File _image;

  Future getImageGaleri() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile;
    });
  }

  Future getImageCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = imageFile;
    });
  }

  Future uploadFoto(context, File imageFoto) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFoto.openRead()));
    var length = await imageFoto.length();
    var uri = Uri.parse("http://arai-music.com/upload/uploadprofil.php");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("foto", stream, length,
        filename: basename(imageFoto.path));

    request.fields["iduser"] = widget.idUserFoto;
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Foto di upload", toastLength: Toast.LENGTH_LONG);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: "Foto Gagal di upload", toastLength: Toast.LENGTH_LONG);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ubah Foto Profil",
          style: TextStyle(fontSize: 14.0),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  child:
                      Center(child: _image == null ? Text("Pilih Foto",style: TextStyle(color: Colors.white),) : Image.file(_image)),
                ),
                Container(
              height: 40.0,
              width: 170,
              color: Colors.black,
              child: FlatButton(
                splashColor: Colors.white,
                onPressed: () {
                  getImageGaleri();
                },
                child: Text(
                  "Ambil dari Galeri",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 40.0,
              width: 170,
              color: Colors.black,
              child: FlatButton(
                splashColor: Colors.white,
                onPressed: () {
                  getImageCamera();
                },
                child: Text(
                  "Ambil dari Kamera",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 40.0,
              width: 170,
              color: Colors.black,
              child: FlatButton(
                splashColor: Colors.white,
                onPressed: () {
                  uploadFoto(context, _image);
                },
                child: Text(
                  "Ubah Foto",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
              ],
            ),
        ),
      ),
    );
  }
}