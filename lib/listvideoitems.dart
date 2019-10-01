import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ListVideoItems extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final String judulVideo;
  final String tglUpload, lirik;

  ListVideoItems({@required this.videoPlayerController, this.looping, this.judulVideo, this.tglUpload, this.lirik, Key key})
      : super(key: key);

  @override
  _ListVideoItemsState createState() => _ListVideoItemsState();
}

class _ListVideoItemsState extends State<ListVideoItems> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            "Video Gagal Dimuat!",
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.judulVideo}"),
        // actions: <Widget>[
        //   PopupMenuButton(
        //     itemBuilder: (BuildContext context){
        //       return [
        //         PopupMenuItem(
        //           child: Text("Suka"),),
        //           PopupMenuItem(
        //           child: Text("Komentari"),),
        //           PopupMenuItem(
        //           child: Text("Favorit"),),
        //       ];
        //     },
        //   )
        // ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListView(
              children: <Widget>[
                Chewie(
                  controller: _chewieController,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Tangga Upload : ${widget.tglUpload}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Lirik :"),
                      Text("${widget.lirik}"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
