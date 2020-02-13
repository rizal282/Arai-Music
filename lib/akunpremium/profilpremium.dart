import 'dart:convert';
import 'package:araiband/akunpremium/editprofil.dart';
import 'package:araiband/akunpremium/ubahfoto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum ProfilEditor { EditProfil, UbahFoto }

class ProfilPremium extends StatefulWidget {
  final String idUser;
  ProfilPremium({this.idUser});

  @override
  _ProfilPremiumState createState() => _ProfilPremiumState();
}

class _ProfilPremiumState extends State<ProfilPremium> {
  Future<List> _getDataUser() async {
    final response = await http.post(
        "http://arai-music.com/getdata/getprofiluser.php",
        body: {"iduser": widget.idUser});

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: TextStyle(fontSize: 14.0),
        ),
      ),
      body: Container(
        child: new FutureBuilder<List>(
          future: _getDataUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemUser(
                    list: snapshot.data,
                                        idUser: widget.idUser,
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ItemUser extends StatelessWidget {
  final List list;
  final String idUser;
  ItemUser({Key key, this.list, this.idUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 90,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child:Icon(Icons.person),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Text(
                          list[i]["nama_lengkap"],
                          style: TextStyle(fontSize: 17),
                        )),
                        SizedBox(
                          width: 130.0,
                        ),
                        PopupMenuButton<ProfilEditor>(
                          onSelected: (ProfilEditor value) {
                            switch (value) {
                              case ProfilEditor.EditProfil:
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfil(
                                          list: list,
                                          idUser: idUser,
                                        )));
                                break;
                              case ProfilEditor.UbahFoto:
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UbahFoto(
                                          idUserFoto: idUser,
                                        )));
                                break;
                              default:
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: ProfilEditor.UbahFoto,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.image),
                                    Text("Ubah Foto")
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: ProfilEditor.EditProfil,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.edit),
                                    Text("Edit Profil")
                                  ],
                                ),
                              )
                            ];
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 440,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Lagu disukai"),
                            Text("8 Item")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Lagu didownload"),
                            Text("8 Item")
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Email Anda"),
                            Text(list[i]["email"])
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Phone"),
                            Text(list[i]["no_hp"])
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Tipe Akun"),
                            Text(list[i]["tipeakun"])
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Status Pengguna"),
                            Text(list[i]["statusakun"])
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Joined"),
                            Text(list[i]["doj"])
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
