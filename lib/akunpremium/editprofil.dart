import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EditProfil extends StatefulWidget {
  final List list;
  final String idUser;
  EditProfil({this.list, this.idUser});

  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  TextEditingController namaLengkap;
  TextEditingController noHp;

  void editProfil(){
    http.post("http://arai-music.com/senddata/updateprofiluser.php", body: {
      "iduser":widget.idUser,
      "namalengkap":namaLengkap.text,
      "notelp":noHp.text
    });

    Fluttertoast.showToast(
          msg: "Profil diubah", toastLength: Toast.LENGTH_LONG);
      Navigator.pop(context);
  }

  @override
  void initState() {
    namaLengkap = new TextEditingController(text: widget.list[0]["nama_lengkap"]);
    noHp = new TextEditingController(text: widget.list[0]["no_hp"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Profil", style: TextStyle(fontSize: 14)),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text("Edit Profil Anda", style: TextStyle(fontSize: 25),),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: namaLengkap,
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap"
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: noHp,
                  decoration: InputDecoration(
                    labelText: "No Telepon"
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  child: FlatButton(
                    splashColor: Colors.white,
                    onPressed: () => editProfil(),
                    child: Text("Edit", style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}