import 'package:encode_app/components/bottom_bar.dart';
import 'package:encode_app/screen/games/quiz/quiz.dart';
import 'package:encode_app/screen/games/quiz/result.dart';
import 'package:encode_app/screen/lecture/lecture.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final int id;
  const QuizScreen({super.key, required this.id});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _questions = const [
    {
      'questionText': 'Who created Flutter?',
      'answers': [
        {'text': 'Facebook', 'score': -2},
        {'text': 'Adobe', 'score': -2},
        {'text': 'Google', 'score': 10},
        {'text': 'Microsoft', 'score': -2},
      ],
    },
    {
      'questionText': 'What is Flutter?',
      'answers': [
        {'text': 'Android Development Kit', 'score': -2},
        {'text': 'IOS Development Kit', 'score': -2},
        {'text': 'Web Development Kit', 'score': -2},
        {
          'text':
              'SDK to build beautiful IOS, Android, Web & Desktop Native Apps',
          'score': 10
        },
      ],
    },
    {
      'questionText': 'Which programming language is used by Flutter',
      'answers': [
        {'text': 'Ruby', 'score': -2},
        {'text': 'Dart', 'score': 10},
        {'text': 'C++', 'score': -2},
        {'text': 'Kotlin', 'score': -2},
      ],
    },
    {
      'questionText': 'Who created Dart programming language?',
      'answers': [
        {'text': 'Lars Bak and Kasper Lund', 'score': 10},
        {'text': 'Brendan Eich', 'score': -2},
        {'text': 'Bjarne Stroustrup', 'score': -2},
        {'text': 'Jeremy Ashkenas', 'score': -2},
      ],
    },
    {
      'questionText':
          'Is Flutter for Web and Desktop available in stable version?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _goToLectures() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LectureScreen(id: widget.id, subjectDescription: '',) 
      )
    );
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    if (mounted) {
      setState(() {
        _questionIndex = _questionIndex + 1;
      });
    }

    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Обратно'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _questionIndex < _questions.length
                      ? Quiz(
                          answerQuestion: _answerQuestion,
                          questionIndex: _questionIndex,
                          questions: _questions,
                        )
                      : Result(_totalScore, _goToLectures),
                ),
              ],
            ),
          );
        },
      ),
      // bottomNavigationBar: BottomMainBar(),
    );
  }
}
