import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/screens/ilceEkraniListesi.dart';
import 'dart:convert';
import '../models/eczane.dart';

class Karakterler extends StatefulWidget {
  @override
  _KarakterlerState createState() => _KarakterlerState();
}

class _KarakterlerState extends State<Karakterler> {

  List<Eczane> karakterDizisi=new List<Eczane>();

  void karakterlerGetir() async {

   //https://www.breakingbadapi.com/api/characters
    //
     Response res=await get('https://eczaneleri.net/api/eczane-api?demo=1&type=json');
     //print(res.body);

    var tumdata=await jsonDecode(res.body);


    setState(() {
     // print(data['data'][1]);

      for(var i=0; i < tumdata['data'].length; i++){
        Eczane k=Eczane();
        k.id=tumdata['data'][i]['CityId'];
        k.sehirisim=tumdata['data'][i]['CityName'];

        karakterDizisi.add(k);

      }


    });
  }

  @override
  void initState() {
    super.initState();
    karakterlerGetir();
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
         itemCount: karakterDizisi.length,
         itemBuilder: (context,index){
           return GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (_) => Ilceler
                 (sehirid: karakterDizisi[index].id)));
             },
             child: ListTile(
               title: Text(karakterDizisi[index].sehirisim,style: TextStyle(color:Theme.of(context).scaffoldBackgroundColor,fontWeight: FontWeight.bold,
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
