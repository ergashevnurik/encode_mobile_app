import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  const Answer(this.selectHandler, this.answerText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: ElevatedButton(
        onPressed: selectHandler, // Pass the function reference
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
            backgroundColor: MaterialStateProperty.all(
              Color.fromRGBO(82, 180, 110, 1)
            ),
            elevation: MaterialStateProperty.all(0),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(EdgeInsets.all(15))
        ),
        child: Text(
          answerText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
