import 'dart:convert';
import 'package:araiband/akunfree/detailpersonil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Personil extends StatefulWidget {
  @override
  _PersonilState createState() => _PersonilState();
}

class _PersonilState extends State<Personil> {
  Future<List> getPersonil() async {
    final response =
        await http.get("http://arai-music.com/getdata/getpersonil.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow[600]),
        title: Text(
          "Personil Arai Band",
          style: TextStyle(color: Colors.yellow[600]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new FutureBuilder<List>(
          future: getPersonil(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemPersonil(list: snapshot.data)
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ItemPersonil extends StatelessWidget {
  final List list;
  ItemPersonil({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => DetailPersonil(idPersonil: list[i]["id_personil"], fotoPersonil: list[i]["foto"],profil: list[i]["profil"],experience: list[i]["pengalaman"],)
                )
              );
            },
            child: Card(
              child: new ListTile(
                title: new Text(list[i]["nama_personil"]),
                leading: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        "http://arai-music.com/bahanarai/personil/${list[i]["foto"]}"
                      )
                    )
                  ),
                ),
                trailing: Icon(Icons.visibility),
                subtitle: new Text(
                  "Posisi : ${list[i]['posisi']}",
                  style: TextStyle(fontSize: 10.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
