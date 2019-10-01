import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Personil extends StatefulWidget {
  @override
  _PersonilState createState() => _PersonilState();
}

class _PersonilState extends State<Personil> {

  Future<List> getPersonil() async {
    final response = await http.get("https://arai-band.000webhostapp.com/getpersonil.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow[600]),
        title: Text("Personil Arai Band",style: TextStyle(color: Colors.yellow[600]),),
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
            onTap: (){
              
            },
            child: Card(
              child: new ListTile(
                title: new Text(list[i]["nama_personil"]),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(
                        "http://192.168.43.171/araiband/bahanarai/${list[i]['foto']}"
                      )
                    )
                  ),
                ),
                trailing: Icon(Icons.visibility),
                subtitle: new Text("Posisi : ${list[i]['posisi']}", style: TextStyle(fontSize: 10.0),),
              ),
            ),
          ),
        );
      },
    );
  }
}