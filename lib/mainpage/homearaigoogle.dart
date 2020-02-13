import 'package:araiband/mainpage/aboutus.dart';
import 'package:araiband/akunfree/album.dart';
import 'package:araiband/akunfree/itemlagu.dart';
import 'package:araiband/akunfree/listvideo.dart';
import 'package:araiband/mainpage/loginuser.dart';
import 'package:araiband/akunfree/personil.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeAraiGoogle extends StatefulWidget {
  final String namaUser, emailUser, fotoUser;

  HomeAraiGoogle({this.namaUser, this.emailUser, this.fotoUser});

  @override
  _HomeAraiGoogleState createState() => _HomeAraiGoogleState();
}

class _HomeAraiGoogleState extends State<HomeAraiGoogle> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  
  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("${widget.namaUser}"),
      accountEmail: Text("${widget.emailUser}"),
      currentAccountPicture: ClipOval(
        child: Image.network(
          "${widget.fotoUser}",
          width: 40.0,
          height: 40.0,
        ),
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        
        ListTile(
          leading: Icon(Icons.info),
          title: Text("Tentang Kami"),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AboutUs()));
          },
        ),
        ListTile(
          leading: Icon(Icons.power_settings_new),
          title: Text("Keluar"),
          onTap: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Perhatian"),
                content: Text("Anda akan keluar"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, 'Batal');
                    },
                    child: Text("Batal"),
                  ),
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                    },
                  )
                ],
              ),
            ).then<String>((returnVal) async {
              if (returnVal == 'OK') {
                googleSignIn.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginUser()));
              } else {
                Navigator.of(context).pop();
              }

              return returnVal;
            });
          },
        ),
      ],
    );

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black87,
        title: new Text(
          "Arai Music",
          style: TextStyle(color: Colors.yellow[600]),
        ),
        iconTheme: IconThemeData(color: Colors.yellow[600]),
      ),
      body: new Container(
        child: ListView(
          children: <Widget>[
            new Container(
              color: Colors.black,
              height: 210.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
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
                      borderRadius: BorderRadius.circular(150.0)),
                  child: Icon(
                    Icons.music_note,
                    size: 45.0,
                    color: Colors.yellow[600],
                  ),
                ),
                 SizedBox(width: 10.0,),
                Text("Hai, ${widget.namaUser}", style: TextStyle(color: Colors.yellow[600], fontSize: 20.0),)
                  ],
                ),
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: FlatButton(
                          splashColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Itemlagu()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.music_note,
                                size: 60.0,
                                color: Colors.yellow[600],
                              ),
                              Text("Semua Lagu",
                                  style: TextStyle(color: Colors.yellow[600]))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: FlatButton(
                          splashColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new ListVideo()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.video_library,
                                size: 60.0,
                                color: Colors.yellow[600],
                              ),
                              Text("Video Clip",
                                  style: TextStyle(color: Colors.yellow[600]))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.only(top: 20.0),),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: FlatButton(
                          splashColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new AlbumLagu()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.album,
                                size: 60.0,
                                color: Colors.yellow[600],
                              ),
                              Text("Album",
                                  style: TextStyle(color: Colors.yellow[600]))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: FlatButton(
                          splashColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new Personil()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.people_outline,
                                size: 60.0,
                                color: Colors.yellow[600],
                              ),
                              Text(
                                "Grup Band",
                                style: new TextStyle(color: Colors.yellow[600]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    "Arai Music Software",
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}
