// import 'package:araiband/itemlagu.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

class RatingMusic extends StatefulWidget {
  final String judulLagu, vokalis, publishing, piclagu;

  RatingMusic(
      {
      this.judulLagu,
      this.vokalis,
      this.publishing,
      this.piclagu});
  @override
  _RatingMusicState createState() => _RatingMusicState();
}

class _RatingMusicState extends State<RatingMusic> {
  TextEditingController komentarLagu = new TextEditingController();
  var rating = 0.0;

  void _kirimFeedbackLagu() async {
    if (rating == 0.0) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Perhatian"),
                content: Text("Anda belum memasukan Rating"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    } else {
      http.post("http://arai-music.com/kirimfeedbacklagu.php",
          body: {"judullagu":widget.judulLagu,"rating": rating.toString(), "komentar": komentarLagu.text});

      komentarLagu.text = "";
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Terimaskasih"),
                content: Text("Feedback Anda sudah dikirim"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback Lagu"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(4.0),
              width: MediaQuery.of(context).size.width,
              height: 210,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "http://arai-music.com/bahanarai/cover_art/${widget.piclagu}"))),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    height: 100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 150,
                                child: Text(
                                  "Judul Lagu",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  widget.judulLagu,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 150,
                                child: Text(
                                  "Vokalis",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  widget.vokalis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 150,
                                child: Text(
                                  "Publishing",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  widget.publishing,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text("Rating"),
            SizedBox(
              height: 20.0,
            ),
            SmoothStarRating(
                allowHalfRating: true,
                onRatingChanged: (v) {
                  rating = v;
                  setState(() {});
                },
                starCount: 5,
                rating: rating,
                size: 40.0,
                color: Colors.black,
                borderColor: Colors.yellow[600],
                spacing: 10.0),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: komentarLagu,
              decoration: InputDecoration(
                  labelText: "Komentar kamu (Opsional)",
                  border: OutlineInputBorder(),
                  hintText: "Masukkan komentar kamu disini"),
              maxLines: 5,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: FlatButton(
                splashColor: Colors.white,
                onPressed: () {
                  _kirimFeedbackLagu();
                },
                child: Text(
                  "Kirim",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
