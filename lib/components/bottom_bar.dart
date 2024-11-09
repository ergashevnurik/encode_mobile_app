import 'package:encode_app/screen/subject/all_subjects.dart';
import 'package:flutter/material.dart';
import 'package:encode_app/screen/dashboard/dashboard.dart';
import 'package:encode_app/screen/login/login.dart';
import 'package:encode_app/screen/profile/profile.dart';
import 'package:encode_app/screen/subject/subject.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomMainBar extends StatefulWidget {
  final int activeIndex; // To track the active tab
  const BottomMainBar({Key? key, required this.activeIndex}) : super(key: key);

  @override
  State<BottomMainBar> createState() => _BottomMainBarState();
}

class _BottomMainBarState extends State<BottomMainBar> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var password = prefs.getString("password");
    setState(() {
      isLoggedIn = username != null && password != null;
    });
  }

  void _navigateToPage(int index, Widget page) {
    if (widget.activeIndex != index) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton(
            0,
            Icons.home,
            'Home',
            Dashboard(),
          ),
          _buildIconButton(
            1,
            Icons.book,
            isLoggedIn ? 'Subjects' : 'All Subjects',
            isLoggedIn ? SubjectScreen() : AllSubjectScreen(),
          ),
          _buildIconButton(
            2,
            isLoggedIn ? Icons.money : Icons.login,
            isLoggedIn ? 'Profile' : 'Login',
            isLoggedIn ? ProfileScreen() : LoginScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(int index, IconData icon, String label, Widget page) {
    final isActive = widget.activeIndex == index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => _navigateToPage(index, page),
          icon: Icon(
            icon,
            color: isActive ? Colors.green : Colors.black,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }
}
