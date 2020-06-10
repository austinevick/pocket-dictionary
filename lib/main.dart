import 'package:dictionary_app/home.dart';
import 'package:dictionary_app/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
      theme: ThemeData(
        primaryColor: Colors.purple
      ),
    );
  }
}