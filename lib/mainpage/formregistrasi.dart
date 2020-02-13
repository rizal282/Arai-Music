import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class FromRegistrasi extends StatefulWidget {
  @override
  _FromRegistrasiState createState() => _FromRegistrasiState();
}

class _FromRegistrasiState extends State<FromRegistrasi> {
  TextEditingController namaLengkap = new TextEditingController();
  TextEditingController noTelepon = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _checkboxval = false;
  String subject, emailBody;

  String validateNama(String value) {
    if (value.isEmpty) {
      return "Isi Nama Anda";
    }

    return null;
  }

  String validatePhone(String value) {
    if (value.isEmpty) {
      return "Isi Nomor Telepon Anda";
    }

    return null;
  }

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

  void emptyFormReg() {
    namaLengkap.text = "";
    noTelepon.text = "";
    email.text = "";
    password.text = "";
  }

  Future _registerUser() async {
    if (_formKey.currentState.validate()) {
      if (_checkboxval == true) {
        final response = await http.post(
            "http://arai-music.com/cekuseremail.php",
            body: {"email": email.text});

        var data = json.decode(response.body);

        if (data["email"] == email.text) {
          Fluttertoast.showToast(
              msg: "Email yang Anda Masukan Sudah Digunakan",
              toastLength: Toast.LENGTH_LONG);
        } else {
          http.post("http://arai-music.com/senddata/daftaruser.php", body: {
            "namaLengkap": namaLengkap.text,
            "noTelepon": noTelepon.text,
            "email": email.text,
            "password": password.text,
            "tipeakun": "Pendengar",
            "statusakun": "Free"
          });

          subject = "Konfirmasi Email Anda";
          emailBody = "Ini adalah pesan email untuk konfirmasi email Anda";

          Fluttertoast.showToast(
              msg: "Akun Anda Sudah Dibuat, Silahkan Login",
              toastLength: Toast.LENGTH_LONG);
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow[600]),
        title: Text(
          "Buat Akun Pendengar",
          style: TextStyle(color: Colors.yellow[600]),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Icon(
                      Icons.person_add,
                      size: 40.0,
                      color: Colors.yellow[600],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                ),
                Text(
                  "Jadilah member Arai Music",
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                ),
                Text(
                  "Daftar Gratis",
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Form(
                  key: _formKey,
                  child: formRegisterUI(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formRegisterUI() {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: namaLengkap,
            keyboardType: TextInputType.text,
            validator: validateNama,
            decoration: InputDecoration(
                hintText: "Nama Lengkap",
                hintStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                prefixIcon: Icon(Icons.person)),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: noTelepon,
            keyboardType: TextInputType.phone,
            validator: validatePhone,
            decoration: InputDecoration(
                hintText: "Nomor Telepon",
                hintStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                prefixIcon: Icon(Icons.phone)),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                prefixIcon: Icon(Icons.email)),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: password,
            keyboardType: TextInputType.text,
            obscureText: true,
            validator: validatePassword,
            decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                prefixIcon: Icon(Icons.lock_outline)),
          ),
          SizedBox(
            height: 20.0,
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
          buildButtonContainer()
        ],
      ),
    );
  }

  Widget buildButtonContainer() {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Colors.black),
      child: FlatButton(
        splashColor: Colors.white,
        onPressed: () {
          _registerUser();
        },
        child: Text(
          "Daftarkan",
          style: TextStyle(color: Colors.yellow[600], fontSize: 18.0),
        ),
      ),
    );
  }
}
