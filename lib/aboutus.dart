import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Future<List> _getAbout() async {
    final response =
        await http.get("https://arai-band.000webhostapp.com/getabout.php");

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.yellow[600]),
        title: Text(
          "Tentang kami",
          style: TextStyle(color: Colors.yellow[600]),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // Where the linear gradient begins and ends
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  stops: [0.1, 0.5, 0.7, 1],
                  colors: [
                    // Colors are easy thanks to Flutter's Colors class.
                    Colors.black,
                    Colors.black54,
                    Colors.black45,
                    Colors.black45,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.grey],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Icon(
                      Icons.music_note,
                      size: 45.0,
                      color: Colors.yellow[600],
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Arai Music",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow[600]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 10.0, bottom: 8.0),
              child: new FutureBuilder<List>(
                future: _getAbout(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  List about = snapshot.data;

                  return snapshot.hasData
                      ? new Text(about[0]["deskripsi"], textAlign: TextAlign.justify,)
                      : new Center(
                          child: new CircularProgressIndicator(),
                        );
                },
              ),
            ),
            Column(

              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  "Arai Music v1.0",
                  style: TextStyle(fontSize: 10.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "DMP & Arai Music Software",
                  style: TextStyle(fontSize: 10.0),
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
