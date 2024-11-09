import 'dart:convert';
import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:encode_app/components/custom_notification_app_bar.dart';
import 'package:encode_app/models/backoffice/subject.dart';
// import 'package:encode_app/models/Subject.dart';
import 'package:encode_app/screen/dashboard/components/button_to_screen.dart';
import 'package:encode_app/screen/dashboard/components/carousel_card.dart';
import 'package:encode_app/screen/dashboard/components/title_forward_redirect.dart';
import 'package:encode_app/screen/games/games.dart';
import 'package:encode_app/screen/library/library.dart';
import 'package:encode_app/screen/login/login.dart';
import 'package:encode_app/screen/promocode/promocode.dart';
import 'package:encode_app/screen/shop/shop.dart';
import 'package:encode_app/screen/statistics/statistic.dart';
import 'package:encode_app/screen/subject/all_subjects.dart';
import 'package:encode_app/screen/subject/subject.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/app_bar.dart';
import '../../components/bottom_bar.dart';
import '../profile/profile.dart';
import 'components/course_container.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';


class Dashboard extends StatefulWidget {
  final NotchBottomBarController? controller;
  const Dashboard({super.key, this.controller});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Subject> subjects = [];
  bool _isLoading = true;
  String? _errorMessage;

  Future<void> fetchSubjects() async {
    final response = await http.get(Uri.parse(
      'http://localhost:8082/subject/api/v1/loadSubjects'),
       headers: {
        'Accept-Charset': 'utf-8', // Optionally set encoding
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        subjects = jsonResponse.map((subject) => Subject.fromJson(subject)).toList();
      });
    } else {
      throw Exception('Failed to load subjects');
    }
  }

  bool _isLoggedIn = false;

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    

    if (isLoggedIn) {
      setState(() {
        _isLoggedIn = isLoggedIn;
      });
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'User not logged in';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSubjects();
    _checkLoginStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding:
          const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarWithNotification(),
              // Container(
              //   width: size.width,
              //   decoration: BoxDecoration(
              //       color: Color.fromRGBO(21, 28, 51, 1),
              //       backgroundBlendMode: BlendMode.multiply,
              //       image: DecorationImage(
              //           image: AssetImage('assets/images/banner_bg.png'),
              //           fit: BoxFit.cover),
              //       borderRadius: BorderRadius.all(Radius.circular(10))),
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 20, bottom: 25, top: 25),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Главная страница',
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 18,
              //               fontWeight: FontWeight.bold),
              //         ),
              //         Text(
              //           'Выбери свои курсы прямо сейчас',
              //           style: TextStyle(color: Color(0xE0D7D7D7)),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 25,
              // ),
              TitleForwardRedirect(
                title: 'Новости',
                description: 'Горячие новости',
                onPressed: () {},
              ),
              SizedBox(
                height: 25,
              ),

              CarouselSlider(
                options: CarouselOptions(
                  height: 220.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 3),
                ),
                items: [
                  // Banner 1
                  CarouselCard(
                    title: 'First news title',
                    description: 'First short description'
                  ),
                  CarouselCard(
                    title: 'Second news title',
                    description: 'Second short description'
                  ),
                  CarouselCard(
                    title: 'Third news title',
                    description: 'Third short description'
                  ),
                ],
              ),


              SizedBox(
                height: 25,
              ),
              TitleForwardRedirect(
                title: 'Наш вайб',
                description: 'Открой для себя мир в Encode School',
                onPressed: () {},
              ),
              SizedBox(
                height: 25,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ButtonToScreen(
                    //   title: 'Игры',
                    //   icon: Icon(
                    //     Icons.gamepad,
                    //     size: 25,
                    //     color: Colors.white,
                    //   ),
                    //   color: Color.fromRGBO(82, 180, 110, 1),
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => GameScreen()));
                    //   },
                    // ),
                    ButtonToScreen(
                      title: 'Магазин',
                      icon: Icon(
                        Icons.shop,
                        size: 25,
                        color: Colors.white,
                      ),
                      color: Color.fromRGBO(21, 28, 51, 1),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopScreen()));
                      },
                    ),
                    ButtonToScreen(
                      title: 'Библиотека',
                      icon: Icon(
                        Icons.book_online,
                        size: 25,
                        color: Colors.white,
                      ),
                      color: Color.fromRGBO(21, 28, 51, 1),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LibraryScreen()));
                      },
                    ),
                    // ButtonToScreen(
                    //   title: 'Курсы',
                    //   icon: Icon(
                    //     Icons.dashboard,
                    //     size: 25,
                    //     color: Colors.white,
                    //   ),
                    //   color: Color.fromRGBO(21, 28, 51, 1),
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => SubjectScreen()));
                    //   },
                    // ),
                    ButtonToScreen(
                      title: 'Топчики',
                      icon: Icon(
                        Icons.leaderboard,
                        size: 25,
                        color: Colors.white,
                      ),
                      color: Color.fromRGBO(21, 28, 51, 1),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StatisticScreen()));
                      },
                    ),
                    ButtonToScreen(
                      title: 'Промо карта',
                      icon: Icon(
                        Icons.card_giftcard,
                        size: 25,
                        color: Colors.white,
                      ),
                      color: Color.fromRGBO(21, 28, 51, 1),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PromoCodeScreen()));
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TitleForwardRedirect(
                title: 'Наши курсы',
                description: 'Подбери идеальные курсы для себя',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => _isLoggedIn ? SubjectScreen() : AllSubjectScreen()));
                },
              ),
              SizedBox(
                height: 25,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: subjects.map((subject) {
                      return CourseContainer(
                        icon: Icon(
                          Icons.book, // You can set an appropriate icon based on the subject
                          color: Colors.white,
                          size: 45,
                        ),
                        title: subject.subjectName,
                        description: subject.subjectDescription,
                      );
                    }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    ),
    bottomNavigationBar: BottomMainBar(activeIndex: 0), 
    drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(21, 28, 51, 1),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation to profile screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation to settings screen
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // Implement logout functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}