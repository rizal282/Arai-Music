import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Playmusik extends StatefulWidget {
  final String fileLagu;
  final String judullagu;
  final String vokal;
  final String album;
  final String picalbum;
  final String label;
  Playmusik({this.fileLagu, this.judullagu, this.vokal, this.album, this.picalbum, this.label});

  @override
  _PlaymusikState createState() => _PlaymusikState();
}

class _PlaymusikState extends State<Playmusik> {
  AudioPlayer player = new AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();

  void play() async {
    int result = await player
        .play("http://arai-music.com/bahanarai/lagu/${widget.fileLagu}");

    if (result == 1) {}
    // print("ini adalah : ${widget.fileLagu}");
  }

  void pause() async {
    int result = await player.pause();

    if (result == 1) {}
  }

  void stop() async {
    int result = await player.stop();

    if (result == 1) {}
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    player.seek(newDuration);
  }

  Future<bool> _stopMusic() {
    stop();

    return new Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    player.onDurationChanged.listen((Duration d) {
      // print("Max Duration : $d");
      setState(() {
        duration = d;
      });
    });

    player.onAudioPositionChanged.listen((Duration p) => setState(() {
          position = p;
        }));
    player.onPlayerCompletion.listen((event) {
      setState(() {
        position = duration;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _stopMusic,
          child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.yellow[600]),
          backgroundColor: Colors.black,
          title: Text("Playing : ${widget.judullagu}",style: TextStyle(color: Colors.yellow[600]),),
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                height: 304.0,
                color: Colors.white,
                child: new Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 250.0,
                        child: Center(
                          child: widget.picalbum == null
                          ? Text("Album Art")
                          : Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "http://arai-music.com/bahanarai/cover_art/${widget.picalbum}"
                                )
                              )
                            ),
                          ),
                        ),
                      ),
                      // Padding(padding: const EdgeInsets.only(top: 5.0),),
                      new Slider(
                        activeColor: Colors.black,
                        inactiveColor: Colors.black45,
                        
                        value: position.inSeconds.toDouble(),
                        min: 0.0,
                        max: duration.inSeconds.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            seekToSecond(value.toInt());
                            value = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              new Container(
                width: 400,
                height: 150.0,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Text("Judul Lagu "),
                        ),
                        Container(
                          width: 200,
                          child: Text(widget.judullagu),
                        )
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Text("Vokal "),
                        ),
                        Container(
                          width: 100,
                          child: Text(widget.vokal),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Text("Album "),
                        ),
                        Container(
                          width: 100,
                          child: Text(widget.album),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Text("Publishing "),
                        ),
                        Container(
                          width: 100,
                          child: Text(widget.label,
                        ),
                        )],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              new Container(
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // Container(
                      //   height: 50.0,
                      //   width: 50.0,
                      //   child: InkWell(
                      //     onTap: () {
                            
                      //     },
                      //     splashColor: Colors.blueAccent,
                      //     child: Icon(Icons.favorite),
                      //   ),
                      // ),
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: InkWell(
                          onTap: () => play(),
                          splashColor: Colors.blueAccent,
                          child: Icon(Icons.play_arrow),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: InkWell(
                          onTap: () => pause(),
                          splashColor: null,
                          child: Icon(Icons.pause),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: InkWell(
                          onTap: () => stop(),
                          splashColor: null,
                          child: Icon(Icons.stop),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
