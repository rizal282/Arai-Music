import 'dart:convert';
import 'package:araiband/homearaigoogle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:araiband/daftarakun.dart';
import 'package:araiband/homearai.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

String idUser, namaUser, emailUser, passwordUser;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arai Music',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Montserrat',
      ),
      home: LoginUser(),
    );
  }
}

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  String alert = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Masukan Email Anda dengan Benar';
    else
      return null;
  }

  void emptyForm() {
    email.text = "";
    password.text = "";
  }

  _loginGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if(googleUser.displayName.isEmpty){
      Navigator.of(context).pop();
    }else{
      Navigator.pushReplacement(context,
      MaterialPageRoute(
        builder: (context) => HomeAraiGoogle(namaUser: googleUser.displayName, emailUser: googleUser.email, fotoUser: googleUser.photoUrl)
      )
    );
    }
  }

  Future _loginUser() async {
    if (_formKey.currentState.validate()) {
      final response = await http.post(
          "https://arai-band.000webhostapp.com/loginuser.php",
          body: {"email": email.text, "password": password.text});

      var dataUser = json.decode(response.body);

      if (dataUser.length == 0) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text("Warning!"),
                  content: Text("Email atau Password Anda Salah"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));

        emptyForm();
      } else {
        setState(() {
          idUser = dataUser[0]["id_user"];
          namaUser = dataUser[0]["nama_lengkap"];
          emailUser = dataUser[0]["email"];
          passwordUser = dataUser[0]["password"];
        });

        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => HomeArai(
                      idUser: idUser,
                      namaUser: namaUser,
                      emailUser: emailUser,
                      passUser: passwordUser,
                    )));
      }
    }
  }

  @override
  void initState(){
    super.initState();
    firebaseAuth.currentUser().then((user){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
        child: ListView(
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
            SizedBox(width: 10.0,),
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
            Center(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: formUI(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Belum punya akun?"),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new DaftarAkun())),
                      child: Center(
                        child: Text(
                          "Daftar Sekarang",
                          style: TextStyle(color: Colors.yellow[600]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Text(
                "Arai Music v1.0",
                style: TextStyle(fontSize: 10.0),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                "DMP & Arai Music Software",
                style: TextStyle(fontSize: 10.0),
              ),
            ),
          ],
        ),
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
            _loginUser();
          },
          child: Text(
            "Masuk",
            style: TextStyle(color: Colors.yellow[600], fontSize: 18.0),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return new Column(
      children: <Widget>[
        TextFormField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          decoration: InputDecoration(
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.black, fontSize: 16.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              prefixIcon: Icon(Icons.email)),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: password,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value.isEmpty) {
              return "Isi Password Anda";
            }

            return null;
          },
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.black, fontSize: 16.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              prefixIcon: Icon(Icons.lock)),
        ),
        SizedBox(
          height: 40.0,
        ),
        buildButtonContainer(),
        SizedBox(
          height: 30.0,
        ),
        Container(
          width: 250.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
          child: InkWell(
            onTap: () => _loginGoogle(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    "gambar/google_logo.png",
                    width: 40.0,
                    height: 40.0,
                  ),
                  Text("Masuk dengan Google")
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
