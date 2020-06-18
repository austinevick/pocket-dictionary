import 'package:dictionary_app/viewModel/dictionaryListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DictionaryListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.purple),
        backgroundColor: Colors.white,
        title: TextField(
          onChanged: (val) {
            provider.populateDictionaryData(val);
          },
          controller: controller,
          style: TextStyle(fontSize: 22),
          cursorColor: Colors.purple,
          decoration: InputDecoration(
              hintText: 'Search',
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none),
        ),
      ),
      body: ListView.builder(
          itemCount: provider.dictionary.length,
          itemBuilder: (context, index) {
            var word = provider.dictionary[index];
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
