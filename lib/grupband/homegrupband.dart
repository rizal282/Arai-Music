import 'package:araiband/grupband/personilband.dart';
import 'package:araiband/grupband/profiluserband.dart';
import 'package:araiband/mainpage/aboutus.dart';
import 'package:araiband/mainpage/loginuser.dart';
import 'package:flutter/material.dart';

class HomeGrupBand extends StatefulWidget {
  final String iduserband, namaUserBand, emailUserBand;
  
  HomeGrupBand({this.iduserband, this.namaUserBand, this.emailUserBand});
  @override
  _HomeGrupBandState createState() => _HomeGrupBandState();
}

class _HomeGrupBandState extends State<HomeGrupBand> {
  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("aaa"),
      accountEmail: Text("bbb"),
      currentAccountPicture: CircleAvatar(
        child: Icon(
          Icons.person,
          color: Colors.black,
          size: 40,
        ),
        backgroundColor: Colors.lightBlue,
      ),
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Profil"),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UserBand()));
          },
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
      appBar: AppBar(),
      body: new ListView(
        children: <Widget>[
          new Container(
            width: double.infinity,
            height: 210,
            color: Colors.black,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 70,
                  height: 70,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(Icons.person),
                ),
                new SizedBox(
                  width: 20.0,
                ),
                new Text(
                  widget.namaUserBand.toUpperCase(),
                  style: new TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          new Container(
            width: double.infinity,
            height: 350,
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
                          onPressed: () {
                           
                          },
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.music_note,
                                color: Colors.white,
                              ),
                              new Text(
                                "Single",
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
                          onPressed: () {
                            
                          },
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
                          onPressed: () {
                            
                          },
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
                          onPressed: () {
                           
                          },
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PersonilBand()));
                          },
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.people,
                                color: Colors.white,
                              ),
                              new Text(
                                "Personil",
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
                          onPressed: () {
                            
                          },
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                              new Text(
                                "Band",
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
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}
