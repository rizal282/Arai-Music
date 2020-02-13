import 'dart:convert';
import 'package:araiband/akunfree/playmusik.dart';
import 'package:araiband/akunfree/ratingmusic.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef void OnError(Exception exception);

enum PageNumber {
  PageRating,
  PageKomentar,
}

class Itemlagu extends StatefulWidget {
  @override
  _ItemlaguState createState() => _ItemlaguState();
}

class _ItemlaguState extends State<Itemlagu> {
  Future<List> getDataLagu() async {
    final response =
        await http.get("http://arai-music.com/getdata/getdatalagu.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow[600]),
        backgroundColor: Colors.black,
        title: Text(
          "Semua Lagu",
          style: TextStyle(color: Colors.yellow[600]),
        ),
      ),
      body: Container(
        child: new FutureBuilder<List>(
          future: getDataLagu(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemList(list: snapshot.data)
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
  ItemList({this.list});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  AudioPlayer player = new AudioPlayer();


  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Playmusik(
                            fileLagu: widget.list[i]["file_lagu"],
                            judullagu: widget.list[i]["judul_lagu"],
                            vokal: widget.list[i]["vokal"],
                            album: widget.list[i]["album"],
                            label: widget.list[i]["label"],
                            picalbum: widget.list[i]["pic_album"],
                          )));
            },
            child: Card(
              child: new ListTile(
                title: new Text(widget.list[i]["judul_lagu"]),
                leading: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "http://arai-music.com/bahanarai/cover_art/${widget.list[i]["pic_album"]}"))),
                ),
                subtitle: new Text(
                  "Album : ${widget.list[i]['judul_lagu']}",
                  style: TextStyle(fontSize: 10.0),
                ),
                trailing: new PopupMenuButton<PageNumber>(
                  onSelected: (PageNumber value) {
                    switch (value) {
                      case PageNumber.PageRating:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RatingMusic(
                                      judulLagu: widget.list[i]["judul_lagu"],
                                      vokalis: widget.list[i]["vokal"],
                                      publishing: widget.list[i]["label"],
                                      piclagu: widget.list[i]["pic_album"],
                                    )));
                        break;
                      default:
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        value: PageNumber.PageRating,
                        child: Text("Feedback"),
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
