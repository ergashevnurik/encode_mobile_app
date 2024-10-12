import 'package:encode_app/components/bottom_bar.dart';
import 'package:encode_app/components/custom_notification_app_bar.dart';
import 'package:encode_app/models/Subject.dart';
import 'package:encode_app/models/Subscriber.dart';
import 'package:encode_app/screen/lecture/lecture.dart';
import 'package:encode_app/service/subject_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  List<Subject> _subjects = [];
  bool _isLoading = true;
  String? _errorMessage;
  late Subscriber _subscriber;
  final SubjectService _subjectService = SubjectService();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      _isLoggedIn = isLoggedIn;
    });

    if (_isLoggedIn) {
      getSubjects();
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'User not logged in';
      });
    }
  }

  Future<void> getSubjects() async {
    try {
      final subjects = await _subjectService.fetchSubjects();
      if (subjects != null) {
        setState(() {
          _subjects = subjects;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load subjects';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'An error occurred';
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshPage() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    await getSubjects();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 20, bottom: 100),
      child: RefreshIndicator(
        onRefresh: _refreshPage,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isLoggedIn) ...[
                  if (_subjects.isNotEmpty) ...[
                    CustomAppBarWithNotification(),
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
                          color: Color.fromRGBO(82, 180, 110, 1),
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
                                subject.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                subject.short_description,
                                style: const TextStyle(color: Colors.white),
                                overflow: TextOverflow.fade,
                                softWrap: true,
                                maxLines: 6,
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(54, 128, 75, 1),
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LectureScreen(
                                        id: subject.id,
                                        subjectDescription: subject.description,
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
                            ],
                          ),
                        ),
                      ),
                  ] else if (_isLoading) ...[
                    Container(
                      height: size.height,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  ] else if (_errorMessage != null) ...[
                    Container(
                      height: size.height,
                      alignment: Alignment.center,
                      child: Text(_errorMessage ?? 'An error occurred'),
                    ),
                  ],
                ] else ...[
                  Container(
                    height: size.height,
                    alignment: Alignment.center,
                    child: const Text('Please log in to view subjects'),
                  ),
                ],
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    ),
    bottomNavigationBar: BottomMainBar(),
    );
  }
}
