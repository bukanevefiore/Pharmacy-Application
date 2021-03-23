import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:pharmacy/screens/eczaneAyrinti.dart';
import 'dart:convert';
import '../models/eczane.dart';

class Eczaneler extends StatefulWidget {

  final int ilceid,ilid;
  Eczaneler({this.ilceid,this.ilid});

  @override
  _EczanelerState createState() => _EczanelerState();
}

class _EczanelerState extends State<Eczaneler> {

  List<Eczane> eczaneListesi=new List<Eczane>();
  bool yukleniyor=false;

  void eczaneleriGetir() async{

    print(widget.ilceid);

    Response res=await get('https://eczaneleri.net/api/eczane-api?demo=1&type=json');

    var tumdata=await jsonDecode(res.body);


    setState(() {

      print(tumdata['data'][0]['area'][0]['pharmacy'][0]['name']);
      for(var i=0;i<tumdata['data'][widget.ilid-1]['area'][widget.ilceid-1]['pharmacy'].length;i++){

        Eczane e=new Eczane();

        e.eczaneid=i+1;
        e.eczanename=tumdata['data'][widget.ilid-1]['area'][widget.ilceid-1]['pharmacy'][i]['name'];

        eczaneListesi.add(e);
        yukleniyor=true;
      }

    });

  }

@override
  void initState() {
    super.initState();
    eczaneleriGetir();
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
          text: ['Eczaneler'],
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
            itemCount: eczaneListesi.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => EczaneAyrinti(ilceid: widget.ilceid,ilid: widget.ilid,eczaneid: eczaneListesi[index].eczaneid)));
                },
                child: ListTile(
                  title: Text(eczaneListesi[index].eczanename,style: TextStyle(color:Theme.of(context).scaffoldBackgroundColor,fontWeight: FontWeight.bold,
                      fontSize: 20.0),),
                  leading: CircleAvatar(
                    backgroundColor: Color(0xff68d5bb),
                    backgroundImage: AssetImage('assets/resimler/doctor.png'),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}

/*


 */