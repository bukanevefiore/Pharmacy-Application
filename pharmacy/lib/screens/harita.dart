import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:pharmacy/models/eczane.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class Harita extends StatefulWidget {

  final int ilceid,ilid,eczaneid;
  Harita({this.ilceid,this.ilid,this.eczaneid});


  @override
  _HaritaState createState() => _HaritaState();


}

class _HaritaState extends State<Harita> {

  Eczane e=new Eczane();

  void googleMap() async{

    print("----------------------------------------");
    print(widget.ilceid);
    print(widget.ilid);

    Response res=await get('https://eczaneleri.net/api/eczane-api?demo=1&type=json');

    var tumdata=await jsonDecode(res.body);

    setState(() {

      var ikiKonum=tumdata['data'][widget.ilid-1]['area'][widget.ilceid-1]['pharmacy'][widget.eczaneid-1]['maps'];
      print(ikiKonum);

      double say=(ikiKonum.length)/2;

      print(say);
      print(',');
      e.eczaneMapsbir=ikiKonum.substring(0,say.toInt());
      e.eczaneMapsiki=ikiKonum.substring(say.toInt()+1);
      print(double.parse(e.eczaneMapsbir));
      print(double.parse(e.eczaneMapsiki));

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harita'),
      ),
      body: GoogleMap(initialCameraPosition: CameraPosition(
          target: LatLng(22.5448131,88.3403691),
          zoom: 15,
      ),),
    );
  }
}
