import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz({
    Key? key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Question(
            questions[questionIndex]['questionText'].toString(),
          ),
          Container(
            child: Column(
              children: [
                ...(questions[questionIndex]['answers']
                        as List<Map<String, Object>>)
                    .map((answer) {
                  return Answer(() => answerQuestion(answer['score']),
                      answer['text'].toString());
                }).toList()
              ],
            ),
          )
        ],
      ),
    ); //Column
  }
}
