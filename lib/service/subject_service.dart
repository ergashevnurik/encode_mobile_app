import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/Subject.dart'; // Adjust the path based on your project structure
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SubjectService {
  final String _baseUrl = dotenv.env['BASE_URL']!; // You can store this in a secure environment later
  // final String _baseUrl = 'http://127.0.0.1:5000';

  // Fetch user ID from SharedPreferences
  Future<String?> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  // Fetch subjects from the API
  Future<List<Subject>?> fetchSubjects() async {
    try {
      String? userId = await _getUserId();

      if (userId == null) {
        throw Exception('User ID not found');
      }

      final response = await http
          .post(
            Uri.parse('$_baseUrl/subject/api/v1/findUsersSubject'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'id': userId}),
          )
          .timeout(const Duration(seconds: 100));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData
            .map((subjectData) => Subject(
                  id: subjectData['id'],
                  title: subjectData['title'],
                  description: subjectData['description'],
                  short_description: subjectData['short_description'],
                  icon: subjectData['icon'],
                  price: subjectData['price'],
                  lang: subjectData['lang'],
                ))
            .toList();
      } else {
        throw Exception('Failed to load subjects');
      }
    } catch (error) {
      print('Error fetching subjects: $error');
      return null;
    }
  }
}
