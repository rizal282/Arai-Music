import 'dart:convert';
import 'package:araiband/akunfree/detailalbum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlbumLagu extends StatefulWidget {
  @override
  _AlbumLaguState createState() => _AlbumLaguState();
}

class _AlbumLaguState extends State<AlbumLagu> {

  Future<List> _getDataAlbum() async {
    final response = await http.get("http://arai-music.com/getdata/getdataalbum.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.yellow[600]),
        title: Text("Album Arai",style: TextStyle(color: Colors.yellow[600]),),
      ),
      body: Container(
        child: new FutureBuilder<List>(
          future: _getDataAlbum(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemAlbum(list: snapshot.data)
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ItemAlbum extends StatelessWidget {
  final List list;
  ItemAlbum({this.list});

  @override
  Widget build(BuildContext context) {
   return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => DetailAlbum(idAlbum: list[i]["id_album"], namaAlbum: list[i]["judul_album"], picAlbum: list[i]["foto_album"],deskripsi: list[i]["deskripsi"],)
                )
              );
            },
            child: Card(
              child: new ListTile(
                title: new Text(list[i]["judul_album"]),
                leading: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(
                        "http://arai-music.com/bahanarai/album_art/${list[i]['foto_album']}"
                      )
                    )
                  )
                ),
                subtitle: new Text("Tahun Rilis: ${list[i]['tahun_rilis']}", style: TextStyle(fontSize: 10.0),),
                trailing: Text('${list[i]['isi_lagu']} Lagu', style: TextStyle(fontSize: 10.0),),
              ),
            ),
          ),
        );
      },
    );
  }
}