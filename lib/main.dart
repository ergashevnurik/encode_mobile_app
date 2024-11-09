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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  static void setLocale(BuildContext context, Locale newLocale) {
    _HomeState? state = context.findAncestorStateOfType<_HomeState>();
    state?.setLocale(newLocale);
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Locale? _locale;

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(), // Use home property directly
      routes: {
        '/home': (context) => Dashboard(), // Define your home screen here
      },
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ru'), // Russian
        Locale('uz'), // Uzbek
        Locale('es'), // Spanish
        Locale('tr'), // Turkish
        Locale('ch'), // Chinese
        Locale('lv'), // Latvian
        // Add more languages as needed
      ],
      locale: _locale,
    );
  }
}
