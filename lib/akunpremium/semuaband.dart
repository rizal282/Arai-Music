import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  final int idband;
  final String personil;
  final String namaband;
  final String genre;

  Post({this.idband, this.personil, this.namaband, this.genre});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      idband: json['userId'],
      personil: json['jml_personil'],
      namaband: json['nama_band'],
      genre: json['genre'],
    );
  }
}

class Allband extends StatefulWidget {
  @override
  _AllbandState createState() => _AllbandState();
}

class _AllbandState extends State<Allband> {
  List<Post> dataBand = [];
  var loading = false;

  Future<Null> _getdataband() async {
    setState(() {
      loading = true;
    });

    final response = await http.get("http://arai-music.com/getdata/getdataband.php");

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);

      setState(() {
        for(Map i in data){
          dataBand.add(Post.fromJson(i));
          loading = false;
        }
      });
    }
  } 

  @override
  void initState() {
    super.initState();
    _getdataband();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Band", style: TextStyle(fontSize: 14.0),),
      ),
      body: Container(
        child: loading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
          itemCount: dataBand.length,
          itemBuilder: (context, i){
            final a = dataBand[i];
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
                      Text(a.namaband, style: TextStyle(fontSize: 15),),
                      Text("${a.personil} Personil")
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