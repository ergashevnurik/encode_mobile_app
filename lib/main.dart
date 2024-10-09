import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:device_preview/device_preview.dart';
import 'package:encode_app/components/bottom_bar.dart';
import 'package:encode_app/screen/dashboard/dashboard.dart';
import 'package:encode_app/screen/login/login.dart';
import 'package:encode_app/screen/onboarding/onboarding.dart';
import 'package:encode_app/screen/profile/profile.dart';
import 'package:encode_app/screen/subject/subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: "assets/.env");
    print('Dotenv loaded successfully');
  } catch (e) {
    print('Error loading .env file: $e');
  }

  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => const Home(),
  //   ),
  // );
  
  runApp(new Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);
  int maxCount = 5;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      Dashboard(
        controller: (_controller),
      ),
      const SubjectScreen(),
      isLoggedIn ? const ProfileScreen() : const LoginScreen(),
    ];
    return MaterialApp(
      // navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 238, 238, 238),
        body: Dashboard(),
        bottomNavigationBar: BottomMainBar(),
      )
      // routes: {
      //   '/dashboard': (context) => Dashboard(),
      //   '/profile': (context) => ProfileScreen()
      // },
      // home: Scaffold(
      //   backgroundColor: Color.fromARGB(255, 238, 238, 238),
      //   body: PageView(
      //   controller: _pageController,
      //   physics: const NeverScrollableScrollPhysics(),
      //   children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
      // ),
      // extendBody: true,
      //   bottomNavigationBar: (bottomBarPages.length <= maxCount)
      //     ? AnimatedNotchBottomBar(
      //         /// Provide NotchBottomBarController
      //         notchBottomBarController: _controller,
      //         color: Colors.white,
      //         showLabel: true,
      //         notchColor: Color.fromRGBO(45, 109, 63, 1),
      //         removeMargins: false,
      //         bottomBarWidth: 100,
      //         showShadow: false,
      //         durationInMilliSeconds: 300,
      //         itemLabelStyle: const TextStyle(fontSize: 10),
      //         bottomBarItems: [
      //           BottomBarItem(
      //             inActiveItem: Icon(
      //               Icons.home_filled,
      //               color: Colors.blueGrey,
      //             ),
      //             activeItem: Icon(
      //               Icons.home_filled,
      //               color: Colors.white,
      //             ),
      //             itemLabel: 'Панель',
      //           ),
      //           BottomBarItem(
      //             inActiveItem: Icon(Icons.book, color: Colors.blueGrey),
      //             activeItem: Icon(
      //               Icons.book,
      //               color: Colors.white,
      //             ),
      //             itemLabel: 'Предметы',
      //           ),
      //           isLoggedIn ? BottomBarItem(
      //             inActiveItem: Icon(
      //               Icons.settings,
      //               color: Colors.blueGrey,
      //             ),
      //             activeItem: Icon(
      //               Icons.settings,
      //               color: Colors.white,
      //             ),
      //             itemLabel: 'Профиль',
      //           ) : BottomBarItem(
      //             inActiveItem: Icon(
      //               Icons.login,
      //               color: Colors.blueGrey,
      //             ),
      //             activeItem: Icon(
      //               Icons.login,
      //               color: Colors.white,
      //             ),
      //             itemLabel: 'Вход',
      //           ),
      //         ],
      //         onTap: (index) {
      //           log('current selected index $index');
      //           _pageController.jumpToPage(index);
      //         },
      //       )
      //     : null,
      // ),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Color.fromRGBO(228, 228, 228, 1)
      //   )
      // ),
    );
  }
}
