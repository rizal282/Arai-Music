import 'dart:convert';
import 'package:araiband/akunfree/listvideoitems.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AllVideo extends StatefulWidget {
  final String stsakun;
  AllVideo({this.stsakun});

  @override
  _AllVideoState createState() => _AllVideoState();
}

class _AllVideoState extends State<AllVideo> {
  Future<List> _getDataVideo() async {
    final response = await http.post("http://arai-music.com/getdata/getdatavideo.php", body: {
      "stsakun" : widget.stsakun
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Video"
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