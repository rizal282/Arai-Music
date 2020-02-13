import 'dart:convert';

import 'package:araiband/akunpremium/carilagu.dart';
import 'package:araiband/akunpremium/profilpremium.dart';
import 'package:araiband/akunpremium/semuaalbum.dart';
import 'package:araiband/akunpremium/semuaband.dart';
import 'package:araiband/akunpremium/semualagu.dart';
import 'package:araiband/akunpremium/semuavideo.dart';
import 'package:araiband/mainpage/aboutus.dart';
import 'package:araiband/mainpage/loginuser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeAraiPremium extends StatefulWidget {
  final String idUser, namaUser, emailUser, stsAkun;

  HomeAraiPremium({this.idUser, this.namaUser, this.emailUser, this.stsAkun});
  @override
  _HomeAraiPremiumState createState() => _HomeAraiPremiumState();
}

class _HomeAraiPremiumState extends State<HomeAraiPremium> {
  // ambil foto profil
  Future<List> _getFotoUser() async {
    final response = await http.post(
        "http://arai-music.com/getdata/getfotoprofil.php",
        body: {"iduser": widget.idUser});

    return json.decode(response.body);

  }

  @override
  Widget build(BuildContext context) {
    final _drawerAkunPremiun = UserAccountsDrawerHeader(
      accountName: Text(widget.namaUser),
      accountEmail: Text(widget.emailUser),
      currentAccountPicture: CircleAvatar(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 40,
            )),
        backgroundColor: Colors.white,
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        _drawerAkunPremiun,
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Profil"),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfilPremium(idUser: widget.idUser))),
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text("Tentang Kami"),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AboutUs()));
          },
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text("Rate on Google Play"),
          onTap: () {},
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
            ).then<String>((returnVal) {
              if (returnVal == 'OK') {
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
      appBar: AppBar(
        title: Text(
          "Arai Music",
          style: TextStyle(fontSize: 14.0),
        ),
        actions: <Widget>[
          new Container(
            height: 50,
            width: 50,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            width: double.infinity,
            height: 210,
            color: Colors.black,
            child: FutureBuilder(
              future: _getFotoUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? new ItemFoto(
                        list: snapshot.data == null ? 0 : snapshot.data,
                        namaUser: widget.namaUser,
                      )
                    : new Center(
                        child: new CircularProgressIndicator(),
                      );
              },
            ),
          ),
          new Container(
            width: double.infinity,
            height: 300,
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Container(
                        width: 90,
                        height: 90,
                        decoration: new BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: FlatButton(
                          splashColor: Colors.white,
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AllLagu(
                                        stsAkun: widget.stsAkun,idUser: widget.idUser,
                                      ))),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.library_music,
                                color: Colors.white,
                              ),
                              new Text(
                                "Lagu",
                                style: new TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      new Container(
                        width: 90,
                        height: 90,
                        decoration: new BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: FlatButton(
                          splashColor: Colors.white,
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AllVideo(
                                        stsakun: widget.stsAkun,
                                      ))),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.video_library,
                                color: Colors.white,
                              ),
                              new Text(
                                "Video",
                                style: new TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Container(
                        width: 90,
                        height: 90,
                        decoration: new BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: FlatButton(
                          splashColor: Colors.white,
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AllAlbum())),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.album,
                                color: Colors.white,
                              ),
                              new Text(
                                "Album",
                                style: new TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      new Container(
                        width: 90,
                        height: 90,
                        decoration: new BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: FlatButton(
                          splashColor: Colors.white,
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Allband())),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.people,
                                color: Colors.white,
                              ),
                              new Text(
                                "Artist",
                                style: new TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                tooltip: "Cari",
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CariLagu())),
              ),
              IconButton(
                icon: Icon(
                  Icons.folder,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              )
            ],
          )),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}

class ItemFoto extends StatelessWidget {
  final List list;
  final String namaUser;
  const ItemFoto({Key key, this.list, this.namaUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list.length == null ? 0 : list.length,
      itemBuilder: (context, i){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  color: Colors.white,
                  child: list.length != null
                  ? Icon(Icons.person) : Image.network("http://arai-music.com/fotoprofil/${list[i]["file_foto"]}"),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
