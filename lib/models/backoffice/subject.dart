import './module.dart';

class Subject {
  final int id;
  final String subjectName;
  final String subjectDescription;
  final List<Module> subjectModuleList;

  Subject({
    required this.id,
    required this.subjectName,
    required this.subjectDescription,
    required this.subjectModuleList,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    var list = json['subjectModuleList'] as List;
    List<Module> moduleList = list.map((i) => Module.fromJson(i)).toList();
    return Subject(
      id: json['id'],
      subjectName: json['subjectName'],
      subjectDescription: json['subjectDescription'],
      subjectModuleList: moduleList,
    );
  }
}
