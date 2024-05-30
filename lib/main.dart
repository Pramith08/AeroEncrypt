import 'package:aeroencrypt/firebase_options.dart';
import 'package:aeroencrypt/pages/login_page.dart';
import 'package:aeroencrypt/pages/onboarding_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.delayed(const Duration(milliseconds: 1500));
  bool onboardingCompleted = await checkOnboardingStatus();
  runApp(MyApp(onboardingCompleted: onboardingCompleted));
}

Future<bool> checkOnboardingStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboardingCompleted') ?? false;
}

class MyApp extends StatelessWidget {
  final bool onboardingCompleted;

  MyApp({Key? key, required this.onboardingCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: onboardingCompleted ? LoginPage() : OnBoardingPage(),
    );
  }
}
