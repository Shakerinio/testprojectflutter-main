import 'package:flutter/material.dart';
import 'package:test_project/utils/globals.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen(
    this.submitFn,
  );
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _passwordVisible = false;
  var checkEmail = true;
  var checkUserName = true;
  var checkPassword = true;
  var _userLogin = '';
  var _userEmail = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin)
                    Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 20,
                      ),
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          checkEmail = false;
                          return 'Please enter a valid email address.';
                        } else {
                          checkEmail = true;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                      ),
                      onSaved: (value) {
                        _userEmail = value!;
                        emailUser = value;
                      },
                    ),
                  if (_isLogin)
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 20,
                      ),
                    ),
                  TextFormField(
                    key: ValueKey('username'),
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        checkUserName = false;
                        return 'Please enter at least 4 characters';
                      }
                      checkUserName = true;
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Username'),
                    onSaved: (value) {
                      _userLogin = value!;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        checkPassword = false;
                        return 'Password must be at least 5 characters long.';
                      }
                      checkPassword = true;
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _passwordVisible = !_passwordVisible;
                            },
                          );
                        },
                      ),
                    ),
                    obscureText: !_passwordVisible,
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Color.fromARGB(255, 255, 255, 255),
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                    onPressed: () async {
                      _trySubmit();

                      if (checkEmail == true &&
                          checkPassword == true &&
                          checkUserName == true) {
                        Navigator.pushNamed(context, '/profile');
                      }
                    },
                  ),
                  FlatButton(
                    textColor: Theme.of(context).accentColor,
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                    onPressed: () {
                      setState(
                        () {
                          _isLogin = !_isLogin;
                          if (_isLogin == false) {
                            appBarTitle = "Registration";
                          } else {
                            appBarTitle = "Login";
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
