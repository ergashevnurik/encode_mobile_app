import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  const Question(this.questionText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Вопрос',
            style: TextStyle(
              color: Color.fromRGBO(82, 180, 110, 1)
            )
          ),
          Text(
            questionText,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ), //Text
    ); //Container
  }
}
