import 'dart:convert';

import 'package:encode_app/models/Subscriber.dart';
import 'package:encode_app/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  final String _baseUrl = dotenv.env['BASE_URL']!;
  // final String _baseUrl = 'http://127.0.0.1:5000';

  List<Subscriber> subscribers = [];
  bool _isLoggedIn = false;
  Subscriber? _subscriber;

  Future<void> login(context, _username, _password) async {
    final username = _username.text;
    final password = _password.text;
    print(username);
    print(password);

    if (username.isNotEmpty) {
      final response = await http.post(Uri.parse('$_baseUrl/auth/api/v1/user'),
          headers: {
            'Content-Type': 'application/json',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept"
          },
          body: jsonEncode({'username': username, 'password': password}));

      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData.containsKey('contact')) {
          print('Login successful for phone number: $username');
          _subscriber = Subscriber(
              id: responseData['id'],
              firstName: responseData['firstName'] != null
                  ? responseData['firstName']
                  : 'N/A',
              last: responseData['last'] != null ? responseData['last'] : 'N/A',
              birthday: responseData['birthday'] != null
                  ? responseData['birthday']
                  : 'N/A',
              gender: responseData['gender'] != null
                  ? responseData['gender']
                  : 'N/A',
              username: responseData['username'] != null
                  ? responseData['username']
                  : 'N/A',
              role: responseData['role'] != null ? responseData['role'] : 'N/A',
              contact: responseData['contact'] != null
                  ? responseData['contact']
                  : 'N/A',
              password: responseData['password'] != null
                  ? responseData['password']
                  : 'N/A',
              coins: responseData['coins'] != null ? responseData['coins'] : 0);
          // EasyLoading.showSuccess("Welcome, ${_subscriber!.first}");
          _isLoggedIn = true;

          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("username", _subscriber!.username);
          pref.setString("password", _subscriber!.password);
          pref.setInt("coins", _subscriber!.coins);
          pref.setString('firstName', _subscriber!.firstName);
          pref.setString('role', _subscriber!.role);
          pref.setString('id', _subscriber!.id);
          pref.setBool("isLoggedIn", true);

          // Navigate to another screen
          // Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Dashboard())
          );
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          //   return Dashboard();
          // }));
        } else {
          print('Login failed: ${responseData['message']}');
        }
      } else {
        EasyLoading.showError('Failed with Error');
        print('Login failed for username or password: $username');
      }
    } else {
      print('Please enter a username or password');
      EasyLoading.showInfo('Please enter a username or password');
    }
  }
}
