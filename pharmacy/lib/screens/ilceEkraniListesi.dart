import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/eczane.dart';

class Ilceler extends StatefulWidget {

  final int sehirid;
  Ilceler({this.sehirid});

  @override
  _IlcelerState createState() => _IlcelerState();
}

class _IlcelerState extends State<Ilceler> {

  List<Eczane> ilceDizisi=new List<Eczane>();

  void ilceleriGetir() async {

    print(widget.sehirid);


    //https://www.breakingbadapi.com/api/characters
    //
    Response res=await get('https://eczaneleri.net/api/eczane-api?demo=1&type=json');
    //print(res.body);

    var tumdata=await jsonDecode(res.body);


    setState(() {
      // print(data['data'][1]);

      for(var i=0; i < tumdata['data'][widget.sehirid]['area'].length; i++){
        Eczane k=Eczane();
        k.countPharmacy=tumdata['data'][widget.sehirid]['area']['countPharmacy'];
        k.ilceName=tumdata['data'][widget.sehirid]['area']['areaName'];

        ilceDizisi.add(k);

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacy'),
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
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Ilceler
                    (sehirid: ilceDizisi[index].id)));
                },
                child: ListTile(
                  title: Text(ilceDizisi[index].ilceName,style: TextStyle(color:Theme.of(context).scaffoldBackgroundColor,fontWeight: FontWeight.bold,
                      fontSize: 20.0),),
                  leading: CircleAvatar(
                    backgroundColor: Color(0xff022f25),//AssetImage('resimler/doctor.jpg'),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }




}
