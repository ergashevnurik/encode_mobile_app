// ignore_for_file: avoid_print

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final int resultScore;
  final void Function() resetHandler;

  const Result(this.resultScore, this.resetHandler, {Key? key})
      : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late ConfettiController _controllerCenter =
      ConfettiController(duration: const Duration(seconds: 10));

  //Remark Logic
  String get resultPhrase {
    String resultText;
    if (widget.resultScore >= 41) {
      resultText = 'Ты молодец';

      print(widget.resultScore);
    } else if (widget.resultScore >= 31) {
      resultText = 'Хорошо!';
      print(widget.resultScore);
    } else if (widget.resultScore >= 21) {
      resultText = 'Нужно стараться больше!';
    } else if (widget.resultScore >= 1) {
      resultText = 'Учись больше!';
    } else {
      resultText = 'Очень низкая оценка!';
      print(widget.resultScore);
    }
    return resultText;
  }

  @override
  void initState() {
    _controllerCenter.play();
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(82, 180, 110, 1)),
            textAlign: TextAlign.center,
          ),
          Text(
            'Результат ${widget.resultScore}',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality.explosive,
            particleDrag: 0.05,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.05,
            shouldLoop: true,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
          ),
          TextButton(
            onPressed: widget.resetHandler, // Pass the function reference
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(82, 180, 110, 1),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: const Text(
                'Завершить',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
