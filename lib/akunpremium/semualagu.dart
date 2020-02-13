import 'dart:convert';
import 'package:araiband/akunpremium/playlagu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class AllLagu extends StatefulWidget {
  final String idUser, stsAkun;
  AllLagu({this.stsAkun, this.idUser});

  @override
  _AllLaguState createState() => _AllLaguState();
}

class _AllLaguState extends State<AllLagu> {
  // ambil semua lagu
  Future<List> _getAllLagu() async {
    final response = await http.post(
        "http://arai-music.com/getdata/getdatalaguforuser.php",
        body: {"stsakun": widget.stsAkun});

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lagu",
          style: TextStyle(fontSize: 14.0),
        ),
      ),
      body: new Container(
        child: new FutureBuilder<List>(
          future: _getAllLagu(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemList(
                    list: snapshot.data,
                    idUser: widget.idUser,
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  final List list;
  final String idUser;
  ItemList({this.list, this.idUser});
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // download lagu
  Future<void> downloadLagu(String namaLagu) async {
    Dio dio = Dio();
    var urlLagu = "http://arai-music.com/bahanarai/lagu/$namaLagu";

    try {
      var dir = await getExternalStorageDirectory();
      await dio.download(urlLagu, "${dir.path}/$namaLagu",
          onReceiveProgress: (rec, total) {
        print("rec : $rec, total : $total");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 5,
              child: new ListTile(
                title: new Text(widget.list[i]["judul_lagu"]),
                leading: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "http://arai-music.com/bahanarai/album_art/${widget.list[i]["pic_album"]}"))),
                ),
                subtitle: new Text(
                  "Penyanyi : ${widget.list[i]['nama_band']}",
                  style: TextStyle(fontSize: 10.0),
                ),
                trailing: PopupMenuButton(
                  onSelected: (String value) {
                    switch (value) {
                      case "Play":
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PlayLagu(
                                  namaLagu: widget.list[i]["file_lagu"],
                                  idLagu: widget.list[i]["id_lagu"],
                                  idUser: widget.idUser,
                                  judulLagu: widget.list[i]["judul_lagu"],
                                  coverart: widget.list[i]["pic_album"],
                                  publisher: widget.list[i]["label"],
                                  vokal: widget.list[i]["pic_album"],
                                )));
                        break;
                      case "Sukai":
                        print("Sukai");
                        break;
                      case "Download":
                        downloadLagu(widget.list[i]["file_lagu"]);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        value: "Play",
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.play_arrow),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Play")
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "Sukai",
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Suka")
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "Download",
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_downward),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Download")
                          ],
                        ),
                      )
                    ];
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
