import './subject.dart';
import './lecture.dart';

class Module {
  final int id;
  final String subjectModuleName;
  final int? createdById;
  final List<Lecture> lectures;

  Module({
    required this.id,
    required this.subjectModuleName,
    this.createdById,
    required this.lectures,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    var list = json['lectures'] as List;
    List<Lecture> lecturesList = list.map((i) => Lecture.fromJson(i)).toList();
    return Module(
      id: json['id'],
      subjectModuleName: json['subjectModuleName'],
      createdById: json['createdById'],
      lectures: lecturesList,
    );
  }
}