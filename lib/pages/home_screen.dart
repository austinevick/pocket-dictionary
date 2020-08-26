import 'package:dictionary_app/viewModel/dictionaryListViewModel.dart';
import 'package:dictionary_app/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _searching = false;
  final controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DictionaryListViewModel>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(
            child: SearchBar(
          controller: controller,
          onChanged: (value) {
            provider.populateSearchPage(value);
          },
          isSearching: _searching,
        )),
        actions: <Widget>[
          IconButton(
            icon: _searching ? Icon(Icons.clear) : Icon(Icons.search),
            onPressed: () {
              setState(() {
                _searching = !_searching;
              });
            },
          ),
        ],
      ),
      body: provider.owlbotDictionary.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'image/img.png',
                    height: 50,
                    colorBlendMode: BlendMode.darken,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Searched words will\n appear here',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: provider.owlbotDictionary.length,
              itemBuilder: (context, index) {
                var word = provider.owlbotDictionary[index];
                return Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          word.type,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    word.imageUrl == null
                        ? Container()
                        : Container(
                            height: 180,
                            padding: EdgeInsets.all(20),
                            child: Image.network(word.imageUrl)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        word.definition,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                );
              }),
    );
  }
}
