import 'package:flutter/material.dart';

import 'package:test_project/screens/auth.dart';
import './screens/profile.dart';
import './utils/globals.dart';

void main() => runApp(const MyApp());

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
      },
    );
  }
}
