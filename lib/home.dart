import 'dart:async';
import 'dart:convert';
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
  StreamController streamController;
  Stream stream;
  Timer timer;

  search() async {
    if (controller.text == null) {
      streamController.add(null);
      return;
    }
    streamController.add('waiting');
    Response response = await http.get(url + controller.text.trim(),
        headers: {"Authorization": "Token " + token});
    streamController.add(jsonDecode(response.body));
  }




  @override
  void initState() {
    streamController = StreamController();
    stream = streamController.stream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dictionary'),
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
                      timer = new Timer(Duration(milliseconds: 2000), () {
                        search();
                      });
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search,
                                size: 28, color: Colors.black),
                            onPressed: () {
                              search();
                            }),
                        labelText: 'Type a word',
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(12.0)),
                  ),
                )),
              ],
            ),
            preferredSize: Size.fromHeight(80.0)),
      ),
      body: Container(
        
        child: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(child: Text('Enter a search word'));
              } else {
                if (snapshot.data == 'waiting')
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return ListView.builder(
                    itemCount: snapshot.data['definitions'].length,
                    itemBuilder: (context, index) {
                      final word = snapshot.data['definitions'][index];
                      return Column(
                        children: <Widget>[
                          Align(alignment: Alignment.centerLeft,
                                                      child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                word['type'],
                                style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          word['image_url'] == null
                              ? Container()
                              : Container(
                                  height: 180,
                                  padding: EdgeInsets.all(20),
                                  child: Image.network(word['image_url'])),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(word['definition'],style: TextStyle(
                              fontSize: 20,fontWeight: FontWeight.w500
                            ),),
                          ),
                          
                        ],
                      );
                    });
              }
            }),
      ),
    );
  }
}
