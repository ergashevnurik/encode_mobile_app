// import 'dart:convert';

// import 'package:encode_app/components/bottom_bar.dart';
// import 'package:encode_app/models/Word.dart';
// import 'package:encode_app/screen/games/components/game_button.dart';
// import 'package:encode_app/screen/games/flash_card.dart';
// import 'package:encode_app/screen/games/learning.dart';
// import 'package:encode_app/screen/games/quiz/main.dart';
// import 'package:encode_app/screen/games/quiz/quiz.dart';
// import 'package:encode_app/screen/games/word_search.dart';
// import 'package:flip_card/flip_card_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flip_card/flip_card.dart';
// import 'package:http/http.dart' as http;

// class GameScreen extends StatefulWidget {
//   const GameScreen({super.key});

//   @override
//   State<GameScreen> createState() => _GameScreenState();
// }

// class _GameScreenState extends State<GameScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Обратно'),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Игры для закрепления',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//               Text(
//                 'Попрактикуйся и заработай encoins',
//                 style: TextStyle(
//                   fontSize: 12,
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//               Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 children: [
//                   GameButtonCard(
//                     title: 'Flash Cards',
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => FlashCardScreen()));
//                     },
//                   ),
//                   GameButtonCard(
//                     title: 'Заучивание',
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LearningScreen()));
//                     },
//                   ),
//                   GameButtonCard(
//                     title: 'Тесты',
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => QuizScreen()));
//                     },
//                   ),
//                   GameButtonCard(
//                     title: 'Пазлы',
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => AlphabetPuzzle()));
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       // bottomNavigationBar: BottomMainBar(),
//     );
//   }
// }
