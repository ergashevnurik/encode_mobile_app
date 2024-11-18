import 'dart:convert';

import 'package:encode_app/components/bottom_bar.dart';
import 'package:encode_app/models/backoffice/subject.dart';
import 'package:encode_app/screen/lecture/lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AllSubjectScreen extends StatefulWidget {
  const AllSubjectScreen({super.key});

  @override
  State<AllSubjectScreen> createState() => _AllSubjectScreenState();
}

class _AllSubjectScreenState extends State<AllSubjectScreen> {
  List<Subject> _subjects = [];
  final String _baseUrl = dotenv.env['BASE_BO_URL']!;

  Future<void> fetchSubjects() async {
    final response = await http.get(Uri.parse(
      '$_baseUrl/subject/api/v1/loadSubjects'),
       headers: {
        'Accept-Charset': 'utf-8', // Optionally set encoding
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        _subjects = jsonResponse.map((subject) => Subject.fromJson(subject)).toList();
      });
    } else {
      throw Exception('Failed to load subjects');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                      'Все курсы',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'курсы доступны так и на русском так и на узбекском языке',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 15),
                    for (var subject in _subjects)
                      Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(21, 28, 51, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.explore,
                                color: Colors.white,
                                size: 45,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                subject.subjectName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                subject.subjectDescription,
                                style: const TextStyle(color: Colors.white),
                                overflow: TextOverflow.fade,
                                softWrap: true,
                                maxLines: 6,
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Color.fromRGBO(161, 169, 194, 0.094),
                                      shadowColor: Colors.transparent,
                                      elevation: 0,
                                      padding: const EdgeInsets.all(20)
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LectureScreen(
                                            id: subject.id,
                                            subjectDescription: subject.subjectDescription,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text('Перейти'),
                                        Icon(Icons.chevron_right),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Color.fromRGBO(161, 169, 194, 0.094),
                                      shadowColor: Colors.transparent,
                                      elevation: 0,
                                      padding: const EdgeInsets.all(20)
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LectureScreen(
                                            id: subject.id,
                                            subjectDescription: subject.subjectDescription,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text('Добавить'),
                                        Icon(Icons.add),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomMainBar(activeIndex: 1),
    );
  }
}