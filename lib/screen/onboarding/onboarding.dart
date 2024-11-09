import 'package:encode_app/main.dart';
import 'package:encode_app/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  String? selectedLanguage;

  final List<Map<String, String>> _onboardingData = [
    {
      'title_key': 'welcome_title',
      'description_key': 'welcome_description',
      'image': 'assets/playstore.png',
    },
    {
      'title_key': 'stay_organized_title',
      'description_key': 'stay_organized_description',
      'image': 'assets/playstore.png',
    },
    {
      'title_key': 'get_started_title',
      'description_key': 'get_started_description',
      'image': 'assets/playstore.png',
    },
  ];

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'flag': 'assets/images/flags/flag_en.png'}, // English
    {'code': 'es', 'flag': 'assets/images/flags/flag_es.png'}, // Spanish
    {'code': 'ru', 'flag': 'assets/images/flags/flag_ru.png'}, // Russian
    {'code': 'uz', 'flag': 'assets/images/flags/flag_uz.png'}, // Uzbek
    {'code': 'tr', 'flag': 'assets/images/flags/flag_tr.png'}, // Turkish
    {'code': 'lv', 'flag': 'assets/images/flags/flag_lv.png'}, // Latvian
    {'code': 'ch', 'flag': 'assets/images/flags/flag_ch.png'}, // Chinese
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (selectedLanguage == null) _buildLanguageSelection(),
            if (selectedLanguage != null) ...[
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) => _buildOnboardingPage(index, localizations),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => _buildDot(index),
                ),
              ),
              const SizedBox(height: 20),
              _currentPage == _onboardingData.length - 1
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: Text(localizations.startNow),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(82, 180, 110, 1)),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: Text(
                        localizations.skip,
                        style: TextStyle(color: Color.fromRGBO(82, 180, 110, 1)),
                      ),
                    ),
              const SizedBox(height: 40),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Select Language',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: _languages.map((language) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedLanguage = language['code'];
                    // Update the app's locale based on selected language code
                    Home.setLocale(context, Locale(selectedLanguage!));
                  });
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: ClipPath(
                    clipper: OctagonClipper(),
                    child: Image.asset(
                      language['flag']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(int index, AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _onboardingData[index]['image']!,
            height: 250,
          ),
          const SizedBox(height: 30),
          Text(
            _getLocalizedString(_onboardingData[index]['title_key']!, localizations),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            _getLocalizedString(_onboardingData[index]['description_key']!, localizations),
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getLocalizedString(String key, AppLocalizations localizations) {
    switch (key) {
      case 'welcome_title':
        return localizations.welcome;
      case 'stay_organized_title':
        return localizations.stayOrganized;
      case 'get_started_title':
        return localizations.getStarted;
      case 'welcome_description':
        return localizations.welcomeDescription;
      case 'stay_organized_description':
        return localizations.stayOrganizedDescription;
      case 'get_started_description':
        return localizations.getStartedDescription;
      default:
        return key; // Fallback to the key if no translation is found
    }
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: _currentPage == index ? 12.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Color.fromRGBO(82, 180, 110, 1) : Colors.grey,
      ),
    );
  }
}

// Custom Octagon Clipper
class OctagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width * 0.75, size.height);
    path.lineTo(size.width * 0.25, size.height);
    path.lineTo(0, size.height * 0.75);
    path.lineTo(0, size.height * 0.25);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}