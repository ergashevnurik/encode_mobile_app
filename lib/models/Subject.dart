class Subject {
  final int id;
  final String title;
  final String description;
  final String short_description;
  final String icon;
  final int price;
  final String lang;

  Subject({
    required this.id,
    required this.title,
    required this.description,
    required this.short_description,
    required this.icon,
    required this.price,
    required this.lang
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      short_description: json['short_description'],
      icon: json['icon'],
      price: json['price'],
      lang: json['lang']
    );
  }

}