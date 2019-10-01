import 'package:flutter/material.dart';

class DetailAlbum extends StatefulWidget {
  final String idAlbum;
  final String namaAlbum;
  final String picAlbum;

  DetailAlbum({this.idAlbum, this.namaAlbum, this.picAlbum});
  @override
  _DetailAlbumState createState() => _DetailAlbumState();
}

class _DetailAlbumState extends State<DetailAlbum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.namaAlbum),
      ),
      body: Container(
        child: Card(
          child: Image.network(
            "https://arai-band.000webhostapp.com/bahanarai/album_art/${widget.picAlbum}"
          ),
        ),
      ),
    );
  }
}