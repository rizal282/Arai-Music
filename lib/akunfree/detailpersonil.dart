import 'package:flutter/material.dart';

class DetailPersonil extends StatefulWidget {
  final String idPersonil, fotoPersonil, profil, experience;

  DetailPersonil({this.idPersonil, this.fotoPersonil, this.profil, this.experience});

  @override
  _DetailPersonilState createState() => _DetailPersonilState();
}

class _DetailPersonilState extends State<DetailPersonil> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow[600]),
        title: Text("Detail Personil", style: TextStyle(color: Colors.yellow[600]),),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: NetworkImage(
                   "http://arai-music.com/bahanarai/personil/${widget.fotoPersonil}" 
                  ),
                  fit: BoxFit.contain
                )
              ),
            ),
            SizedBox(height: 10.0,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Profile : "),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.profil),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Pengalaman : "),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.experience),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}