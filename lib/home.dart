import 'dart:async';
import 'dart:convert';
import 'package:dictionary_app/dictionary.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'apikey.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = new TextEditingController();

  Timer timer;

  Future<List<Dictionary>> search() async {
    Response response = await http.get(url + controller.text.trim(),
        headers: {"Authorization": "Token " + token});
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['definitions'];
      List<Dictionary> dictionary =
          result.map((e) => Dictionary.fromMap(e)).toList();
      return dictionary;
    } else
      return throw ('error ocurred');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    style: TextStyle(fontSize: 22),
                    controller: controller,
                    onChanged: (value) {
                      if (timer?.isActive ?? false) timer.cancel();
                      timer = new Timer(Duration(milliseconds: 1000), () {
                        search();
                      });
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search,
                                size: 30, color: Colors.black),
                            onPressed: () {
                             // search();
                            }),
                        labelText: 'Type a word',
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(12.0)),
                  ),
                )),
              ],
            ),
            preferredSize: Size.fromHeight(50.0)),
      ),
      body: FutureBuilder(
          future: search(),
          builder: (context, snapshot) {
            List<Dictionary> dictionary = snapshot.data;
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                  children: dictionary
                      .map(
                        (items) => Card(
                            child: ListTile(
                         
                          title: Text(items.type),
                        )),
                      )
                      .toList());
            }
          }),
    );
  }
}
