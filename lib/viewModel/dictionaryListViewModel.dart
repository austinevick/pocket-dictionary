import 'package:dictionary_app/models/dictionary.dart';
import 'package:dictionary_app/viewModel/dictionaryViewModel.dart';
import 'package:dictionary_app/webservice/webservice.dart';
import 'package:flutter/cupertino.dart';

class DictionaryListViewModel extends ChangeNotifier {
  List<OwlbotDictionaryViewModel> owlbotDictionary =
      List<OwlbotDictionaryViewModel>();
  Future<void> populateSearchPage(String keyword) async {
    List<OwlbotDictionary> dictionaryList =
        await Webservice().fetchDictionaryByKeyword(keyword);
    this.owlbotDictionary = dictionaryList
        .map((dictionary) => OwlbotDictionaryViewModel(dictionary: dictionary))
        .toList();
    notifyListeners();
  }

  List<RapidApiDictionaryViewModel> rapidApiDictionary =
      List<RapidApiDictionaryViewModel>();
  Future<void> populateHomePage() async {
    List<RapidApiDictionary> dictionary = await Webservice().fetchRandomWords();
    this.rapidApiDictionary = dictionary
        .map(
            (dictionary) => RapidApiDictionaryViewModel(dictionary: dictionary))
        .toList();
    notifyListeners();
  }
}
