import 'package:araiband/aboutus.dart';
import 'package:araiband/album.dart';
import 'package:araiband/feedbackuser.dart';
import 'package:araiband/itemlagu.dart';
import 'package:araiband/listvideo.dart';
import 'package:araiband/main.dart';
// import 'package:araiband/personil.dart';
import 'package:araiband/slidepersonil.dart';
import 'package:flutter/material.dart';

class HomeArai extends StatefulWidget {
  final String idUser, namaUser, emailUser, passUser;

  HomeArai({this.idUser, this.namaUser, this.emailUser, this.passUser});

  @override
  _HomeAraiState createState() => _HomeAraiState();
}

class _HomeAraiState extends State<HomeArai> {
  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("${widget.namaUser}"),
      accountEmail: Text("${widget.emailUser}"),
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
        // ListTile(
        //   leading: Icon(Icons.person),
        //   title: Text("Profil Anda"),
        //   onTap: () {},
        // ),
        ListTile(
          leading: Icon(Icons.feedback),
          title: Text("Buat Feedback"),
          trailing: Text("Pelajari Selengkapnya...", style : TextStyle(fontSize: 7.0),),
          onTap: () {
            Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => FeedbackUser()
              )
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text("Tentang Kami"),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AboutUs()
              )
            );
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
                      new Card(
                        color: Colors.black87,
                        elevation: 10.0,
                        child: new Container(
                          height: 100.0,
                          width: 150.0,
                          child: new Center(
                            child: new InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new Itemlagu()));
                              },
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.library_music,
                                    size: 60.0,
                                    color: Colors.yellow[600],
                                  ),
                                  Text(
                                    "Semua Lagu",
                                    style: new TextStyle(
                                        color: Colors.yellow[600]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      new Card(
                        color: Colors.black87,
                        elevation: 10.0,
                        child: new Container(
                          height: 100.0,
                          width: 150.0,
                          child: new Center(
                            child: new InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new ListVideo()));
                              },
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.video_label,
                                    size: 60.0,
                                    color: Colors.yellow[600],
                                  ),
                                  Text(
                                    "Video Clip",
                                    style: new TextStyle(
                                        color: Colors.yellow[600]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: const EdgeInsets.only(top: 20.0),),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Card(
                        color: Colors.black87,
                        elevation: 10.0,
                        child: new Container(
                          height: 100.0,
                          width: 150.0,
                          child: new Center(
                            child: new InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new AlbumLagu()));
                              },
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.album,
                                    size: 60.0,
                                    color: Colors.yellow[600],
                                  ),
                                  Text(
                                    "Semua Album",
                                    style: new TextStyle(
                                        color: Colors.yellow[600]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      new Card(
                        color: Colors.black87,
                        elevation: 10.0,
                        child: new Container(
                          height: 100.0,
                          width: 150.0,
                          child: new Center(
                            child: new InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new SlidePersonil()));
                              },
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.people_outline,
                                    size: 60.0,
                                    color: Colors.yellow[600],
                                  ),
                                  Text(
                                    "Personil",
                                    style: new TextStyle(
                                        color: Colors.yellow[600]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
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
                    "DMP & Arai Music Software",
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
