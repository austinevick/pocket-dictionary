import 'dart:convert';

import 'package:dictionary_app/apikey.dart';
import 'package:dictionary_app/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  networkRequest() async {
    Response response = await get(rapidUrl, headers: {
      "x-rapidapi-host": "wordsapiv1.p.rapidapi.com",
      "x-rapidapi-key": "$rapidapikey"
    });
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
      
    } else {
      print(response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Word of the day'),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              })
        ],
      ),
      body: FutureBuilder(
          future: networkRequest(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.blue,
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Text(snapshot.data['word'],
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data['results'][0]['partOfSpeech'],
                          style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70),
                            ),
                            SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data['results'][0]['definition'],
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 12),
                    child: Text(
                      'SYNONYMS',
                      style: TextStyle(fontSize: 22, color: Colors.black45),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      snapshot.data['results'][0]['synonyms'][0],
                      style: TextStyle(fontSize: 22, color: Colors.blue),
                    ),
                  ),
                  
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
