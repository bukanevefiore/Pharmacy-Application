import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cardOlusturucu(String leading,String title){

  return Card(
    elevation: 0,
    color: Colors.transparent,
    margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
    child: ListTile(
      leading: Text(leading,style: TextStyle(color: Colors.black,fontSize: 20.0),),
      title: Text(title,style: TextStyle(color: Colors.white,fontSize: 18.0),),
    ),
  );
}