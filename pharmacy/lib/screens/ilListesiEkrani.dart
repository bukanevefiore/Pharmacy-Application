import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/screens/ilceListesiEkrani.dart';
import 'dart:convert';
import '../models/eczane.dart';

class Karakterler extends StatefulWidget {
  @override
  _KarakterlerState createState() => _KarakterlerState();
}

class _KarakterlerState extends State<Karakterler> {

  List<Eczane> karakterDizisi=new List<Eczane>();
  bool yukleniyor=false;

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
        k.id=i+1;
        k.sehirisim=tumdata['data'][i]['CityName'];

        karakterDizisi.add(k);
        yukleniyor=true;

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
    return yukleniyor == false ? Scaffold(
      body: Center(
        child: SpinKitCubeGrid(color: Color(0xff1e6656),size: 75.0),
      ),
    ): Scaffold(
      appBar: AppBar(
        title: Text('Şehir'),
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
               print(karakterDizisi[index].id.toString());
               Navigator.push(context, MaterialPageRoute(builder: (_) => Ilceler(id: karakterDizisi[index].id)));
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
