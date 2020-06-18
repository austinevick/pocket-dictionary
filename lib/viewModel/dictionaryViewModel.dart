import 'package:dictionary_app/models/dictionary.dart';

class DictionaryViewModel {
  OwlbotDictionary _owlbotDictionary;
  DictionaryViewModel({OwlbotDictionary dictionary})
      : _owlbotDictionary = dictionary;

  String get type {
    return _owlbotDictionary.type;
  }

  String get imageUrl {
    return _owlbotDictionary.imageUrl;
  }

  String get definition {
    return _owlbotDictionary.definition;
  }
}
