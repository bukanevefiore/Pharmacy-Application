import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:pharmacy/fonksiyonlar/card.dart';
import 'package:pharmacy/screens/harita.dart';
import '../models/eczane.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_fade/image_fade.dart';
import 'package:flutter_button/flutter_button.dart';


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
    var Button;
    return yukleniyor == false ? Scaffold(
      body: Center(
        child: SpinKitCubeGrid(color: Color(0xff1e6656),size: 75.0),
      ),
    ): Scaffold(
      appBar: AppBar(
        title: TypewriterAnimatedTextKit(
          text: [e.eczanename],
          repeatForever: true,
          textStyle: TextStyle(
              fontSize: 20.0,
              fontFamily: "Agne",
              fontStyle: FontStyle.italic,
          ),
          speed: Duration(milliseconds: 500),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 140),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).backgroundColor,Theme.of(context).scaffoldBackgroundColor],
                tileMode: TileMode.mirror
            ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
              bottomLeft: Radius.circular(2),
              bottomRight: Radius.circular(2)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageFade(
                image: AssetImage('assets/resimler/ayrinti.png'),
                height: 100,
                alignment: Alignment.bottomLeft,
                fit: BoxFit.cover,
                fadeDuration: Duration(seconds: 3),
                fadeCurve: Curves.bounceInOut,
              ),
              SizedBox(
                height: 5.0,
                width: 200.0,
                child: Divider(
                  color: Theme.of(context).accentColor,
                ),
              ),
             cardOlusturucu('İsim: ', e.eczanename),
              cardOlusturucu('Telefon: ', e.eczanePhone),
              cardOlusturucu('Adres: ', e.eczaneAddress),
              FloatingActionButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Harita(ilceid: widget.ilceid,ilid: widget.ilid,eczaneid: widget.eczaneid,),
                      ),
                  ),
              ),
            ],
          ),
        ),

      ),
    );

  }
}

