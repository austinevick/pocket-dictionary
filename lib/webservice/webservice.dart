import 'dart:convert';

import 'package:dictionary_app/api_key.dart';
import 'package:dictionary_app/models/dictionary.dart';
import 'package:http/http.dart' as http;

class Webservice {
Future<List<OwlbotDictionary>> fetchDictionaryByKeyword(String keyword) async {
  final String url = "https://owlbot.info/api/v4/dictionary/$keyword";
  final response =
      await http.get(url, headers: {'Authorization': 'Token ' + owlbotApikey});
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result['definitions'];
    return list.map((dic) => OwlbotDictionary.fromMap(dic)).toList();
  } else {
    print(response.statusCode);
    throw Exception("Unable to fetch data");
  }
}
  
}
