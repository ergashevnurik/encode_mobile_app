class SubjectDetails {
  final int id;
  final int subject_id;
  final String student_id;

  SubjectDetails({
    required this.id,
    required this.subject_id,
    required this.student_id
  });

  factory SubjectDetails.fromJson(Map<String, dynamic> json) {
    return SubjectDetails(
      id: json['id'],
      subject_id: json['subject_id'],
      student_id: json['student_id']
    );
  }
}