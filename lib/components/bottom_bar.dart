import 'package:encode_app/screen/dashboard/dashboard.dart';
import 'package:encode_app/screen/login/login.dart';
import 'package:encode_app/screen/profile/profile.dart';
import 'package:encode_app/screen/subject/subject.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomMainBar extends StatefulWidget {
  const BottomMainBar({super.key});

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

  @override
  Widget build(BuildContext context) {
    bool isPressed = false;
    return BottomAppBar(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard())
              );
            },
            icon: Icon(
              Icons.home,
              // color: Color.fromRGBO(82, 180, 110, 1),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubjectScreen())
              );
            },
            icon: Icon(
              Icons.book,
              color: Colors.black,
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.shop,
          //     color: Colors.black,
          //   ),
          // ),
          IconButton(
            onPressed: () {
              setState(() {
                isPressed = !isPressed;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => isLoggedIn ? ProfileScreen() : LoginScreen()),
              );
            },
            icon: Icon(
              isLoggedIn ? Icons.money : Icons.login,
            ),
          )
        ],
      ),
    );
  }
}

