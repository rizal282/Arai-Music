import 'dart:convert';
import 'package:araiband/akunfree/listvideoitems.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class ListVideo extends StatefulWidget {
  @override
  _ListVideoState createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  Future<List> _getDataVideo() async {
    final response =
        await http.get("http://arai-music.com/getdata/getdatavideo.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.yellow[600]),
        backgroundColor: Colors.black87,
        title: Text(
          "Video Arai Music",
          style: TextStyle(color: Colors.yellow[600]),
        ),
      ),
      body: Container(
        child: new FutureBuilder<List>(
          future: _getDataVideo(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemVideo(list: snapshot.data)
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ItemVideo extends StatelessWidget {
  final List list;

  ItemVideo({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListVideoItems(judulVideo: list[i]["judul_video"], tglUpload: list[i]["tgl_upload"], deskripsi: list[i]["deskripsi"],
                            videoPlayerController: VideoPlayerController.network(
                                "http://arai-music.com/bahanarai/vclip/${list[i]["file_video"]}"),
                          )));
            },
            child: Card(
              child: new ListTile(
                trailing: Icon(Icons.play_arrow),
                title: new Text(list[i]["judul_video"]),
                leading: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        "http://arai-music.com/bahanarai/cover_vclip/${list[i]["cover_art"]}"
                      )
                    )
                  ),
                ),
                // trailing: Icon(Icons.visibility),
              ),
            ),
          ),
        );
      },
    );
  }
}

