import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:encode_app/components/custom_notification_app_bar.dart';
import 'package:encode_app/screen/dashboard/components/button_to_screen.dart';
import 'package:encode_app/screen/dashboard/components/title_forward_redirect.dart';
import 'package:encode_app/screen/games/games.dart';
import 'package:encode_app/screen/library/library.dart';
import 'package:encode_app/screen/login/login.dart';
import 'package:encode_app/screen/promocode/promocode.dart';
import 'package:encode_app/screen/shop/shop.dart';
import 'package:encode_app/screen/statistics/statistic.dart';
import 'package:encode_app/screen/subject/subject.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/app_bar.dart';
import '../../components/bottom_bar.dart';
import 'components/course_container.dart';

class Dashboard extends StatefulWidget {
  final NotchBottomBarController? controller;
  const Dashboard({super.key, this.controller});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var password = prefs.getString("password");
    print(username);
    print(password);
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: username == null || password == null ? LoginScreen() : Dashboard(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(top: 15, bottom: 100),
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
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(21, 28, 51, 1),
                      backgroundBlendMode: BlendMode.multiply,
                      image: DecorationImage(
                          image: AssetImage('assets/images/banner_bg.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 25, top: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Главная страница',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Выбери свои курсы прямо сейчас',
                          style: TextStyle(color: Color(0xE0D7D7D7)),
                        )
                      ],
                    ),
                  ),
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
                        color: Color.fromRGBO(82, 180, 110, 1),
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
                        color: Color.fromRGBO(82, 180, 110, 1),
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
                        MaterialPageRoute(builder: (context) => SubjectScreen()));
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CourseContainer(
                          icon: Icon(
                            Icons.explore,
                            color: Colors.white,
                            size: 45,
                          ),
                          title: 'FRONT-END',
                          description:
                              'Погрузитесь в мир веб-разработки, изучите HTML, CSS, JavaScript. Создавайте привлекательные и интерактивные веб-приложения с помощью современных инструментов.'),
                      CourseContainer(
                        icon: Icon(
                          Icons.language,
                          color: Colors.white,
                          size: 45,
                        ),
                        title: 'АНГЛИЙСКИЙ ЯЗЫК',
                        description:
                            'Изучайте легко и уверенно с носителями языка. Поддерживающая атмосфера и интересные задания для повседневного общения и карьерного роста.',
                      ),
                      CourseContainer(
                        icon: Icon(
                          Icons.calculate,
                          color: Colors.white,
                          size: 45,
                        ),
                        title: 'МАТЕМАТИКА',
                        description:
                            'Улучшите аналитические способности и решайте сложные задачи с легкостью. Профессиональные преподаватели помогут в освоении теории и практических навыков.',
                      ),
                      CourseContainer(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 45,
                        ),
                        title: 'CORE JAVA',
                        description:
                            'Отличное начало для изучения Java. Основы языка, структуры данных и алгоритмы для стабильных программистских основ.',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
