import 'package:encode_app/components/bottom_bar.dart';
import 'package:encode_app/screen/login/login.dart';
import 'package:encode_app/screen/profile/components/profile_icon_text_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // For making API calls
import 'dart:convert'; // For JSON encoding

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? id;
  String? username;
  String? password;
  int? coins;
  String? firstName;
  String? profileImg;
  String? role;
  String? localizedRole;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id");
      username = prefs.getString("username");
      password = prefs.getString("password");
      coins = prefs.getInt("coins");
      firstName = prefs.getString("firstName");
      profileImg = prefs.getString("profileImg");
      role = prefs.getString("role");
      localizedRole = _getLocalizedRole(role);
    });
  }

  String _getLocalizedRole(String? role) {
    if (role == 'super_admin') {
      return 'Супер админ';
    } else if (role == 'admin') {
      return 'Администратор';
    } else {
      return 'Студент';
    }
  }

  Future<void> _saveProfileData(String key, dynamic value) async {
    const apiUrl = 'http://127.0.0.1:5000/api/update_profile';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id, // Ensure you are sending the correct user identifier
        'username': username, // Send username if necessary
        key: value, // Send the dynamic key-value pair (password, firstName, etc.)
      }),
    );

    if (response.statusCode == 200) {
      // Update the locally stored value
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value is String) {
        prefs.setString(key, value);
      } else if (value is int) {
        prefs.setInt(key, value);
      }

      // Reload user data after saving
      _loadUserData();
    } else {
      // Handle error
      print('Failed to save data: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 100),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Color.fromARGB(255, 233, 233, 233),
                        ),
                        child: profileImg != null
                            ? Image.asset(profileImg!)
                            : const Icon(
                                Icons.person,
                                size: 24,
                              ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '$username',
                        style: const TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                ProfileCard(
                  title: 'Пароль',
                  text: password ?? 'Loading...',
                  icon: const Icon(Icons.lock, size: 24, color: Colors.white),
                  onSave: (value) => _saveProfileData('password', value),
                ),
                const SizedBox(height: 15),
                ProfileCard(
                  title: 'Имя',
                  text: firstName ?? 'Loading...',
                  icon: const Icon(Icons.abc, size: 24, color: Colors.white),
                  onSave: (value) => _saveProfileData('firstName', value),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear(); // Clear all data
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                      return const LoginScreen();
                    }));
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        child: const Icon(
                          Icons.logout,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: const Text(
                          'Выйти',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomMainBar(activeIndex: 2),
    );
  }
}
