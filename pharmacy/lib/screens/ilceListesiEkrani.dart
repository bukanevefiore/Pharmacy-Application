import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/screens/eczaneListesiEkrani.dart';
import 'dart:convert';
import '../models/eczane.dart';

class Ilceler extends StatefulWidget {

  final int id;
  Ilceler({this.id});

  @override
  _IlcelerState createState() => _IlcelerState();
}

class _IlcelerState extends State<Ilceler> {

  List<Eczane> ilceDizisi=new List<Eczane>();
  bool yukleniyor=false;

  void ilceleriGetir() async {

    print(widget.id);


    //https://www.breakingbadapi.com/api/characters
    //
    Response res=await get('https://eczaneleri.net/api/eczane-api?demo=1&type=json');
    //print(res.body);

    var tumdata=await jsonDecode(res.body);


    setState(() {


      for(var i=0; i < tumdata['data'][widget.id-1]['area'].length; i++){

        Eczane k=Eczane();
        k.countPharmacy=i+1;
        k.ilceName=tumdata['data'][widget.id -1]['area'][i]['areaName'];
        print(tumdata['data'][widget.id -1]['area'][i]['areaName']);
        print("\n");
        ilceDizisi.add(k);
        yukleniyor=true;


      }


    });
  }

  @override
  void initState() {
    super.initState();
    ilceleriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return yukleniyor == false ? Scaffold(
      body: Center(
        child: SpinKitCubeGrid(color: Color(0xff1e6656),size: 75.0),
      ),
    ): Scaffold(
      appBar: AppBar(
        title: TypewriterAnimatedTextKit(
          text: ['İlçeler'],
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
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).backgroundColor,Theme.of(context).scaffoldBackgroundColor],
                tileMode: TileMode.mirror
            )
        ),
        child: ListView.builder(
            itemCount: ilceDizisi.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  print(ilceDizisi[0].countPharmacy);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Eczaneler(ilceid: ilceDizisi[index].countPharmacy,ilid: widget.id)));
                },
                child: ListTile(
                  title: Text(ilceDizisi[index].ilceName,style: TextStyle(color:Theme.of(context).scaffoldBackgroundColor,fontWeight: FontWeight.bold,
                      fontSize: 20.0),),
                  leading: CircleAvatar(
                    backgroundColor: Color(0xff68d5bb),
                    backgroundImage: AssetImage('assets/resimler/ilce.png'),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }




}
