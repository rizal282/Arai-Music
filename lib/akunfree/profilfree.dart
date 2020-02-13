import 'package:araiband/akunfree/uploadfotoprofil.dart';
import 'package:flutter/material.dart';

class ProfilFree extends StatefulWidget {
  final String idUser, namaUser, fotoUser;

  ProfilFree({this.idUser, this.namaUser, this.fotoUser});
  @override
  _ProfilFreeState createState() => _ProfilFreeState();
}

class _ProfilFreeState extends State<ProfilFree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil Anda",
          style: TextStyle(fontSize: 14.0),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            image: widget.fotoUser == null
                                ? Icon(Icons.person)
                                : NetworkImage(
                                    "http://arai-music.com/fotoprofile/${widget.fotoUser}"))),
                  ),
                  Text(widget.namaUser, style: TextStyle(color: Colors.white),),
                  FlatButton(
                    splashColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UploadProfil(
                                idUser: widget.idUser,
                              )));
                    },
                    child: Text(
                      "Ubah Foto",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 360,
              color: Colors.blue,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Email"),
                      SizedBox(width: 20.0,),
                      Text("data")
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Phone"),
                      SizedBox(width: 20.0,),
                      Text("data")
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Sebagai"),
                      SizedBox(width: 20.0,),
                      Text("data")
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Paket Akun"),
                      SizedBox(width: 20.0,),
                      Text("data")
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Date of Join"),
                      SizedBox(width: 20.0,),
                      Text("data")
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    width: 200,
                    height: 40.0,
                    color: Colors.black,
                    child: FlatButton(
                      splashColor: Colors.white,
                      onPressed: (){},
                      child: Text("Upgrade Premium", style: TextStyle(color: Colors.white),)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


