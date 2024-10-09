import 'dart:convert';
import 'package:encode_app/models/Lecture.dart';
import 'package:encode_app/screen/games/flash_card.dart';
import 'package:encode_app/service/lecture_service.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LectureScreen extends StatefulWidget {
  final int id;
  final String subjectDescription;

  const LectureScreen({
    super.key,
    required this.id,
    required this.subjectDescription,
  });

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  final LectureService _lectureService = LectureService();
  List<Lecture> _lectures = [];
  bool _isLoading = true;
  String? _errorMessage;

  Future<void> getLectures() async {
    try {
      final lectures = await _lectureService.fetchLectures(widget.id);
      if (lectures != null) {
        setState(() {
          _lectures = lectures;
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

  @override
  void initState() {
    super.initState();
    getLectures();
  }

  Future<void> _refreshPage() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    await getLectures();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Обратно'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                if (_lectures.isNotEmpty) ...[
                  Html(data: widget.subjectDescription),
                  for (var lecture in _lectures)
                    ExpansionTile(
                      title: Text(lecture.title),
                      children: [
                        // if (lecture.videoUrl != null && lecture.videoUrl.isNotEmpty) 
                          // YoutubePlayer(
                          //   controller: YoutubePlayerController(
                          //     initialVideoId: YoutubePlayer.convertUrlToId(lecture.videoUrl!)!,
                          //     flags: const YoutubePlayerFlags(
                          //       autoPlay: false,
                          //       mute: false,
                          //     ),
                          //   ),
                          //   showVideoProgressIndicator: true,
                          // ),
                        ListTile(
                          title: Html(data: lecture.description),
                          selectedTileColor: const Color.fromRGBO(82, 180, 110, 1),
                          selectedColor: const Color.fromRGBO(82, 180, 110, 1),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(54, 128, 75, 1),
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            padding: const EdgeInsets.all(15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FlashCardScreen(id: widget.id),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Заработать encoins'),
                              Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                ] else if (_isLoading) ...[
                  const CircularProgressIndicator(),
                ] else ...[
                  SizedBox(
                    height: size.height,
                    child: const Center(
                      child: Text('оооо что-то пошло не так'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
