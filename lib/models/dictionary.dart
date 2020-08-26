class OwlbotDictionary {
  final String type;
  final String imageUrl;
  final String definition;

  OwlbotDictionary({this.type, this.imageUrl, this.definition});

  factory OwlbotDictionary.fromMap(Map<String, dynamic> map) {
    return OwlbotDictionary(
        type: map['type'],
        imageUrl: map['image_url'],
        definition: map['definition']);
  }
}

class RapidApiDictionary {
  final String word;
  final String definition;
  final String partOfSpeech;
  final int zero;
  final int one;
  final int two;

  RapidApiDictionary(
      {this.word,
      this.definition,
      this.partOfSpeech,
      this.zero,
      this.one,
      this.two});
  factory RapidApiDictionary.fromMap(Map map) {
    return RapidApiDictionary(
        word: map['word'],
        definition: map['results']['definition'],
        partOfSpeech: map['results']['partOfSpeech'],
        zero: map['synonyms'][0],
        one: map['synonyms'][1],
        two: map['synonyms'][2]);
  }
}
