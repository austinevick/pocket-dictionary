class Dictionary{
  final String type;
  final String definition;
  final String image_url;

  Dictionary({this.type, this.definition, this.image_url});

  factory Dictionary.fromMap(Map<String, dynamic> map){
    return Dictionary(
      type: map['type'],
      definition: map['definition'],
      image_url: map['image_url']
    );
  }
  
}