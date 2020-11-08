import 'package:flutter/material.dart';
import 'package:music_app/Screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(); // will initializeApp
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      highContrastDarkTheme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}
