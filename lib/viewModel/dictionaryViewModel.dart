import 'package:dictionary_app/models/dictionary.dart';

class OwlbotDictionaryViewModel {
  OwlbotDictionary _owlbotDictionary;
  OwlbotDictionaryViewModel({OwlbotDictionary dictionary})
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

class RapidApiDictionaryViewModel {
  RapidApiDictionary _rapidApiDictionary;
  RapidApiDictionaryViewModel({RapidApiDictionary dictionary})
      : _rapidApiDictionary = dictionary;
  String get word {
    return _rapidApiDictionary.word;
  }

  String get definition {
    return _rapidApiDictionary.definition;
  }

  String get partOfSpeech {
    return _rapidApiDictionary.partOfSpeech;
  }

  int get zero {
    return _rapidApiDictionary.zero;
  }

  int get one {
    return _rapidApiDictionary.one;
  }

  int get two {
    return _rapidApiDictionary.two;
  }
}
