import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_project/screens/authScreen.dart';

import 'screens/profileScreen.dart';
import 'screens/weatherScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        backgroundColor: Colors.pink,
        accentColor: Colors.orange,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.deepPurple,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: AuthScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => AuthScreen(),
        '/profile': (BuildContext context) => const ProfileScreen(),
        '/weather': (BuildContext context) => WeatherScreen(),
      },
    );
  }
}
