import 'package:dictionary_app/models/dictionary.dart';
import 'package:dictionary_app/viewModel/dictionaryViewModel.dart';
import 'package:dictionary_app/webservice/webservice.dart';
import 'package:flutter/cupertino.dart';

class DictionaryListViewModel extends ChangeNotifier {
  List<DictionaryViewModel> dictionary = List<DictionaryViewModel>();
  Future<void> populateDictionaryData(String keyword) async {
    List<OwlbotDictionary> dictionaryList =
        await Webservice().fetchDictionaryByKeyword(keyword);
    this.dictionary = dictionaryList
        .map((dictionary) => DictionaryViewModel(dictionary: dictionary))
        .toList();
    notifyListeners();
  }
}
