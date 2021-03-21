import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class Karakterler extends StatefulWidget {
  @override
  _KarakterlerState createState() => _KarakterlerState();
}

class _KarakterlerState extends State<Karakterler> {

  void karakterlerGetir() async {


   // https://www.breakingbadapi.com/api/characters
     Response res=await get('https://eczaneleri.net/api/eczane-api?demo=1&type=json');
     print(res.body);

/*
    var url=Uri.parse('https://www.breakingbadapi.com/api/');
    var response= await http.post(url,body: {'name': 'doodle','color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read('https://example.com/foobar.txt'));




    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url =
    Uri.https('www.breakingbadapi.com', '/api/', {'q': '{http}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }


 */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacy'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
           karakterlerGetir();
          },
          child: Text('Eczanaleri Getir'),
        ),
      ),
    );
  }
}
