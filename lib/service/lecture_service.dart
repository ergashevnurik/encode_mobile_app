import 'dart:convert';
import 'package:encode_app/models/Lecture.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:video_player/video_player.dart';

class LectureService {
  final String _baseUrl = dotenv.env['BASE_URL']!;
  // final String _baseUrl = 'http://127.0.0.1:5000';
  // Map<int, VideoPlayerController> _videoControllers = {};

  Future<List<Lecture>?> fetchLectures(id) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/lecture/api/v1/findAll'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData
            .map((lecture) => Lecture(
                id: lecture['id'],
                duration: lecture['duration'] ?? 'N/A',
                title: lecture['title'] ?? 'N/A',
                description: lecture['description'] ?? 'N/A',
                path: lecture['path'] ?? 'N/A',
                locked: lecture['locked'] ?? false,
                subject_id: lecture['subject_id']))
            .toList();

        // Initialize video controllers for each lecture
        // for (var lecture in _lectures) {
        //   _videoControllers[lecture.id] = VideoPlayerController.networkUrl(
        //       Uri.http(
        //           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
        //       // lecture.path, // Assuming 'path' contains the video URL
        //       )
        //     ..initialize().then((_) {}).catchError((error) {
        //       print('Error initializing video player: $error');
        //     });
        // }

      } else {
        throw Exception("Failed to load lectures");
      }
    } catch (error) {
      print('Error fetching lectures: $error');
      return null;
    }
  }
}
