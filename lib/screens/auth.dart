import 'package:flutter/material.dart';

import 'package:test_project/utils/globals.dart' as global;
import 'package:test_project/widgets/login.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {}

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Authentication'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: LoginScreen(_submitAuthForm),
    );
  }
}
