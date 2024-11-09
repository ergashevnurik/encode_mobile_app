class Lecture {
  final int id;
  final String lectureName;
  final int createdById;

  Lecture({required this.id, required this.lectureName, required this.createdById});

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      id: json['id'],
      lectureName: json['lectureName'],
      createdById: json['createdById'],
    );
  }
}