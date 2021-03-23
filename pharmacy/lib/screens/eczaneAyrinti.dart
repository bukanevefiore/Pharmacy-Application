import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import '../models/eczane.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class EczaneAyrinti extends StatefulWidget {

  final int ilceid,ilid,eczaneid;
  EczaneAyrinti({this.ilceid,this.ilid,this.eczaneid});

  @override
  _EczaneAyrintiState createState() => _EczaneAyrintiState();
}

class _EczaneAyrintiState extends State<EczaneAyrinti> {

  Eczane e=new Eczane();
  bool yukleniyor=false;


  void eczaneAyrintiGetir() async{

    Response res=await get('https://eczaneleri.net/api/eczane-api?demo=1&type=json');

    var tumdata=await jsonDecode(res.body);

    setState(() {

      print(widget.ilid+widget.eczaneid+widget.ilid);
      print(tumdata['data'][widget.ilid-1]['area'][widget.ilceid-1]['pharmacy'][widget.eczaneid-1]['name']);

      e.eczanename=tumdata['data'][widget.ilid-1]['area'][widget.ilceid-1]['pharmacy'][widget.eczaneid-1]['name'];
      e.eczanePhone=tumdata['data'][widget.ilid-1]['area'][widget.ilceid-1]['pharmacy'][widget.eczaneid-1]['phone'];
      e.eczaneAddress=tumdata['data'][widget.ilid-1]['area'][widget.ilceid-1]['pharmacy'][widget.eczaneid-1]['address'];

      yukleniyor=true;
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eczaneAyrintiGetir();

  }

  @override
  Widget build(BuildContext context) {
    return yukleniyor == false ? Scaffold(
      body: Center(
        child: SpinKitCubeGrid(color: Color(0xff1e6656),size: 75.0),
      ),
    ): Scaffold(
      appBar: AppBar(
        title: Text(e.eczanename),

      ),
    );
  }
}
