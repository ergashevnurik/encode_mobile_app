class Word {
  final int id;
  final String word;
  final String meaning;
  final String code;

  Word({
    required this.id,
    required this.word,
    required this.meaning,
    required this.code
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      word: json['word'],
      meaning: json['meaning'],
      code: json['code']
    );
  }
}