import 'dart:convert';

import 'package:encode_app/models/Subscriber.dart';
import 'package:encode_app/screen/dashboard/dashboard.dart';
import 'package:encode_app/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  List<Subscriber> subscribers = [];
  bool _isLoggedIn = false;
  Subscriber? _subscriber;
  final LoginService _loginService = LoginService();

  Future<void> _login() async {
    try {
      // Call login with text values of controllers
      await _loginService.login(
          context, _usernameController.text, _passwordController.text);
    } catch (error) {
      setState(() {
        _errorMessage = 'An error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(25.0),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/banner_bg.png'),
                          fit: BoxFit.cover,
                          opacity: 0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 35),
                        Image.asset('assets/images/logo_dark.png', width: 200),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Пожалуйста введите имя пользователя',
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Пожалуйста введите пароль',
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                            onPressed: _isLoggedIn ? null : _login,
                            child: const Text(
                              'Войти',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(82, 180, 110, 1),
                              onPrimary: Colors.white,
                              padding: const EdgeInsets.all(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'ШКОЛА СОВРЕМЕННЫХ ПРОФЕССИЙ!',
                          style: TextStyle(
                            fontFamily: 'Playwrite USA Modern',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
