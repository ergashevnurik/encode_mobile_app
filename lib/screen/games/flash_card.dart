import 'dart:convert';

import 'package:encode_app/components/bottom_bar.dart';
import 'package:encode_app/models/Word.dart';
import 'package:encode_app/screen/games/word_search.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FlashCardScreen extends StatefulWidget {
  final int id;
  const FlashCardScreen({super.key, required this.id});

  @override
  State<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen> {
  final String _baseUrl = dotenv.env['BASE_URL']!;
  late FlipCardController _controller;
  List<Word> wordList = [];
  String? _errorMessage;
  bool? _isLoading;

  Future<void> _loadWords() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/words/api/v1/findAll'),
        headers: {'Content-Type': 'application/json'}, // Set the content type
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          wordList = responseData.map((w) => Word(
            id: w['id'],
            word: w['word'],
            meaning: w['meaning'],
            code: w['code']
          )).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load data';
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        _errorMessage = 'An error occurred';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController(); // Initialize one FlipCardController
    _loadWords();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Обратно'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: PageView(
        children: [
          if (wordList.isNotEmpty) ...[
            for (var word in wordList) 
              buildFlipCard(size, Color.fromRGBO(64, 124, 81, 1), Color.fromRGBO(82, 180, 110, 1), '${word.word}', '${word.meaning}'),
          ],
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => AlphabetPuzzle(
                        id: widget.id
                      )
                    )
                  );
                }, 
                icon: Icon(
                  Icons.arrow_circle_right,
                ),
              ),
              Text(
                'Перейти к след уроку'
              )
            ],
          )
        ],
      ),
      // bottomNavigationBar: BottomMainBar(),
    );
  }

  Widget buildFlipCard(Size size, Color frontColor, Color backColor, String cardTitle, String backTitle) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: FlipCard(
        controller: _controller, // Use the same controller for all cards
        flipOnTouch: true, // Enable flip on touch
        front: Container(
          width: size.width,
          child: ElevatedButton(
            onPressed: () => _controller.toggleCard(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Читай и повторяй',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 245, 226, 226),
                    fontSize: 12
                  ),
                ),
                Text(
                  '$cardTitle',
                  style: TextStyle(
                    fontSize: 18
                  ),
                )
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: frontColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        back: Container(
          width: size.width,
          child: ElevatedButton(
            onPressed: () => _controller.toggleCard(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Учи и повторяй',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 245, 226, 226),
                    fontSize: 12
                  ),
                ),
                Text(
                  '$backTitle',
                  style: TextStyle(
                    fontSize: 18
                  ),
                )
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: backColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
