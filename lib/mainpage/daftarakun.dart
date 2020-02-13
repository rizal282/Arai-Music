import 'package:araiband/mainpage/formregistrasi.dart';
import 'package:araiband/grupband/buatakunband.dart';
import 'package:flutter/material.dart';

class DaftarAkun extends StatefulWidget {
  @override
  _DaftarAkunState createState() => _DaftarAkunState();
}

class _DaftarAkunState extends State<DaftarAkun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow[600]),
        title: Text(
          "Buat Akun",
          style: TextStyle(color: Colors.yellow[600]),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.grey],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Icon(
                      Icons.music_note,
                      size: 45.0,
                      color: Colors.yellow[600],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Arai Music",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(height: 50.0,),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: FlatButton(
                onPressed: (){
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => FromRegistrasi()
                  ));
                },
                child: Text("Sebagai Pendengar",style: TextStyle(color: Colors.yellow[600], fontSize: 16.0),),
                splashColor: Colors.white,
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: FlatButton(
                onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => BuatAkunBand()
                    )
                  );
                },
                child: Text("Sebagai Grup Band",style: TextStyle(color: Colors.yellow[600], fontSize: 16.0),),
                splashColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
