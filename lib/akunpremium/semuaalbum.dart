import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataAlbumm{
  final String grupband;
  final String namaAlbum;
  final String genre;

  DataAlbumm({this.grupband, this.namaAlbum, this.genre});

  factory DataAlbumm.fromJson(Map<String, dynamic> dataAlbum) {
    return DataAlbumm(
      grupband : dataAlbum["nama_band"],
      namaAlbum : dataAlbum["judul_album"],
      genre : dataAlbum["genre"]
    );
  }
}

class AllAlbum extends StatefulWidget {
  @override
  _AllAlbumState createState() => _AllAlbumState();
}

class _AllAlbumState extends State<AllAlbum> {
  List<DataAlbumm> listDataAlbum = [];
  var loading = false;

  Future<Null> getDatAlbum() async {
    setState(() {
      loading = true;
    });

    final response = await http.get("http://arai-music.com/getdata/getdataalbum.php");

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);

      setState(() {
        for(Map i in data){
          listDataAlbum.add(DataAlbumm.fromJson(i));
          loading = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDatAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album", style: TextStyle(fontSize: 14.0),),
      ),
      body: Container(
        child: loading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
          itemCount: listDataAlbum.length,
          itemBuilder: (context, i){
            final a = listDataAlbum[i];
            return Container(
              padding: EdgeInsets.all(8),
              child: Container(
                height: 90,
                child: Card(
                  elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(Icons.group),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(a.namaAlbum, style: TextStyle(fontSize: 15),),
                      Text(a.genre)
                    ],
                  ),
                  Container(
                    width: 50,
                    child: FlatButton(
                      onPressed: (){},
                      child: Icon(Icons.visibility),
                    ),
                  )
                                    ],
                                  ),
                                ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}