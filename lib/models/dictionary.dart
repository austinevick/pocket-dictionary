class OwlbotDictionary {
  final String type;
  final String imageUrl;
  final String definition;

  OwlbotDictionary({this.type, this.imageUrl, this.definition});

  factory OwlbotDictionary.fromMap(Map<String,dynamic> map){
    return OwlbotDictionary(
      type: map['type'],
      imageUrl: map['image_url'],
      definition: map['definition']
    );
  }
}