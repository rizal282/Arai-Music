import 'package:flutter/material.dart';

class DetailAlbum extends StatefulWidget {
  final String idAlbum;
  final String namaAlbum;
  final String picAlbum, deskripsi;

  DetailAlbum({this.idAlbum, this.namaAlbum, this.picAlbum,this.deskripsi});
  @override
  _DetailAlbumState createState() => _DetailAlbumState();
}

class _DetailAlbumState extends State<DetailAlbum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow[600]),
        title: Text(widget.namaAlbum, style: TextStyle(color: Colors.yellow[600]),),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Card(
              child: Image.network(
                "http://arai-music.com/bahanarai/album_art/${widget.picAlbum}"
              ),
            ),

            SizedBox(height: 20.0,),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(widget.namaAlbum),
                  SizedBox(height: 10.0,),
                  Text("Deskripsi Album"),
                  SizedBox(height: 10.0,),
                  Text(widget.deskripsi),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}