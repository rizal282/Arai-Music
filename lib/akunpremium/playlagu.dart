import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

class PlayLagu extends StatefulWidget {
  final String idUser, idLagu, namaLagu;
  final String judulLagu, vokal, publisher, coverart;
  const PlayLagu({this.namaLagu, this.idUser, this.idLagu, this.judulLagu, this.vokal, this.publisher, this.coverart});

  @override
  _PlayLaguState createState() => _PlayLaguState();
}

class _PlayLaguState extends State<PlayLagu> {
  AudioPlayer audioplay = new AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();

  void pause() async {
    int result = await audioplay.pause();

    if (result == 1) {}
  }

  void stop() async {
    int result = await audioplay.stop();

    if (result == 1) {}
  }

  void play() async {
    int result = await audioplay.play("http://arai-music.com/bahanarai/lagu/${widget.namaLagu}");

    if (result == 1) {}
    // print("ini adalah : ${widget.fileLagu}");
  }
  
  void playlagu() async {
    // cek play lagu
    await http.post("http://arai-music.com/senddata/insertplaylagu.php", body: {
      "iduser":widget.idUser,
      "idlagu":widget.idLagu
    });
 
    play();
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioplay.seek(newDuration);
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    audioplay.onDurationChanged.listen((Duration d) {
      // print("Max Duration : $d");
      setState(() {
        duration = d;
      });
    });

    audioplay.onAudioPositionChanged.listen((Duration p) => setState(() {
          position = p;
    }));

    audioplay.onPlayerCompletion.listen((event) {
      setState(() {
        position = duration;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Judul Lagu", style: TextStyle(color: Colors.white, fontSize: 14),),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 270,
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("vokal", style: TextStyle(color: Colors.white,),),
                      SizedBox(width: 20,),
                      Text("data", style: TextStyle(color: Colors.white,),)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Judul", style: TextStyle(color: Colors.white, fontSize: 20),),
                      SizedBox(width: 20,),
                      Text("data", style: TextStyle(color: Colors.white, fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Publishing", style: TextStyle(color: Colors.white,),),
                      SizedBox(width: 20,),
                      Text("data", style: TextStyle(color: Colors.white,),)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Slider(
                    activeColor: Colors.white24,
                    inactiveColor: Colors.blue,
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
            Container(
              height: 90,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    child: FlatButton(
                      splashColor: Colors.white,
                      onPressed: (){
                        playlagu();
                      },
                      child: Icon(Icons.play_arrow, size: 40, color: Colors.white,),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    child: FlatButton(
                      splashColor: Colors.white,
                      onPressed: (){
                        pause();
                      },
                      child: Icon(Icons.pause, size: 40, color: Colors.white,),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    child: FlatButton(
                      splashColor: Colors.white,
                      onPressed: (){
                        stop();
                      },
                      child: Icon(Icons.stop, size: 40, color: Colors.white,),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}