import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BuatAkunBand extends StatefulWidget {
  @override
  _BuatAkunBandState createState() => _BuatAkunBandState();
}

class _BuatAkunBandState extends State<BuatAkunBand> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController namaPembuat = new TextEditingController();
  TextEditingController emailPembuat = new TextEditingController();
  TextEditingController phonePembuat = new TextEditingController();
  TextEditingController passPembuat = new TextEditingController();
  TextEditingController repassPembuat = new TextEditingController();

  bool _checkboxval = false;

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Masukan Email Anda dengan Benar';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 8) {
      return "Isi Password Anda Minimal 8 Karakter";
    }

    return null;
  }

  String validateRePassword(String value) {
    if (value.isEmpty) {
      return "Masukan Ulang Password Anda";
    } else if (value != passPembuat.text) {
      return "Password Anda Tidak Sama";
    }
    return null;
  }

  // Email dan Password Sign up
  Future registerAkunBand() async {
    if (_formKey.currentState.validate()) {
      if (_checkboxval == false) {
      } else {
        final response = await http.post("http://arai-music.com/cekuseremail.php",
          body: {"email": emailPembuat.text});

      var data = json.decode(response.body);

      if (data["email"] == emailPembuat.text) {
        Fluttertoast.showToast(
            msg: "Email yang Anda Masukan Sudah Digunakan",
            toastLength: Toast.LENGTH_LONG);
      } else {
        http.post("http://arai-music.com/daftaruser.php", body: {
          "namaLengkap": namaPembuat.text,
          "noTelepon": phonePembuat.text,
          "email": emailPembuat.text,
          "password": passPembuat.text,
          "tipeakun" : "Band",
          "statusakun" : "Premium"
        });
      }

        Fluttertoast.showToast(
            msg: "Akun Anda Berhasil Didaftarkan, Silahkan Login",
            toastLength: Toast.LENGTH_LONG);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat Akun Grup Band",
            style: TextStyle(fontSize: 15.0, color: Colors.yellow[600])),
        iconTheme: IconThemeData(color: Colors.yellow[600]),
      ),
      body: new Container(
        padding: EdgeInsets.all(10.0),
        child: new ListView(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
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
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: _formKey,
              child: registerGrupBand(),
            )
          ],
        ),
      ),
    );
  }

  Widget registerGrupBand() {
    return new Container(
      child: new Column(
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "Masukan Nama Anda";
              }

              return null;
            },
            controller: namaPembuat,
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(
              hintText: "Masukan Nama Pembuat",
              labelText: "Nama Pembuat",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: validateEmail,
            controller: emailPembuat,
            keyboardType: TextInputType.emailAddress,
            decoration: new InputDecoration(
              hintText: "Masukan Email",
              labelText: "Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "Masukan Nomor Telepon Anda";
              }

              return null;
            },
            controller: phonePembuat,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              hintText: "Masukan Nomor Telepon",
              labelText: "Nomor Telepon",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: validatePassword,
            controller: passPembuat,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: new InputDecoration(
              hintText: "Masukan Password",
              labelText: "Password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: validateRePassword,
            controller: repassPembuat,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: new InputDecoration(
              hintText: "Masukan Ulang Password",
              labelText: "Ulang Password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  setState(() => this._checkboxval = value);
                },
                value: this._checkboxval,
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Text(
                      "Saya setuju dengan Ketentuan dan Kebijakan Arai Music"))
            ],
          ),
          Divider(),
          SizedBox(
            height: 25.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20.0)),
            child: FlatButton(
              onPressed: () {
                registerAkunBand();
              },
              child: Text(
                "Buat Akun",
                style: TextStyle(color: Colors.yellow[600]),
              ),
              splashColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
