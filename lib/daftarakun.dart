import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DaftarAkun extends StatefulWidget {
  @override
  _DaftarAkunState createState() => _DaftarAkunState();
}

class _DaftarAkunState extends State<DaftarAkun> {
  TextEditingController namaLengkap = new TextEditingController();
  TextEditingController noTelepon = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      http.post("https://arai-band.000webhostapp.com/daftaruser.php", body: {
        "namaLengkap": namaLengkap.text,
        "noTelepon": noTelepon.text,
        "email": email.text,
        "password": password.text
      });

      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Selamat"),
                content: Text("Akun Anda Sudah Dibuat"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
      emptyFormReg();
    }
  }

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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Icon(
                      Icons.person,
                      size: 60.0,
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
                  height: 40.0,
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
            height: 40.0,
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
      child: Center(
        child: InkWell(
          onTap: () {
            _registerUser();
          },
          child: Text(
            "Daftarkan",
            style: TextStyle(color: Colors.yellow[600], fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
