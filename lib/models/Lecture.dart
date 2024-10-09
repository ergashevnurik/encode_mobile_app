class Lecture {
  final int id;
  final int duration;
  final String title;
  final String description;
  final String path;
  final bool locked;
  final int subject_id;
  // final String videoUrl;

  Lecture({required this.id, required this.duration, required this.title, required this.description, required this.path, required this.locked, required this.subject_id});

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      id: json['id'], 
      duration: json['duration'], 
      title: json['title'], 
      description: json['description'], 
      path: json['path'], 
      locked: json['locked'], 
      subject_id: json['subject_id'],
      // videoUrl: json['videoUrl']
    );
  }

}