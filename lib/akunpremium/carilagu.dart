import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CariLagu extends StatefulWidget {
  @override
  _CariLaguState createState() => _CariLaguState();
}

class _CariLaguState extends State<CariLagu> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _radioVal = "";
  String dari;
  
  void _handleRadioChanged(String value){
    setState(() {
      _radioVal = value;

      switch(_radioVal){
        case "Lagu" :
          dari = "Lagu";
        break;
        case "Band" :
          dari = "Band";
        break;
        default:
          Fluttertoast.showToast(msg: "Foto di upload", toastLength: Toast.LENGTH_LONG);
          Navigator.pop(context);
      }
    });
  }

  void cariData(){
    if(_formKey.currentState.validate()){
      print(dari);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cari Lagu atau Band", style: TextStyle(fontSize: 14.0),),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Cari Sesuatu", style: TextStyle(fontSize: 20),),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Masukan Pencarian",
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return "Isi Kolom Pencarian";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        value: "Lagu",
                        groupValue: _radioVal,
                        onChanged: _handleRadioChanged,
                      ),
                      Text("Lagu"),
                      new Radio(
                        value: "Band",
                        groupValue: _radioVal,
                        onChanged: _handleRadioChanged,
                      ),
                      Text("Band"),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color: Colors.black,
                    child: FlatButton(
                      splashColor: Colors.white,
                      onPressed: () => cariData(),
                      child: Text("Cari", style: TextStyle(color: Colors.white),),
                    ),
                  )
                ],
              ),
          ),
      ),
    );
  }
}