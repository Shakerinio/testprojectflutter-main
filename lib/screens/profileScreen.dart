import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_project/utils/globals.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  var _Edit = false;
  var checkFirstName = true;
  var checkLasttName = true;
  var checkEmail = true;
  var checkUserName = true;
  var checkAge = true;

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
        ),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Text('Logout'),
                      SizedBox(width: 8),
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              appBarTitle = "Login";
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance
                    .signOut()
                    .then((value) => Navigator.pushNamed(context, '/login'));
              }
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
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
                    TextFormField(
                      enabled: _Edit,
                      initialValue: firstNameUser,
                      enableSuggestions: false,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          checkFirstName = false;
                          return 'Please fill in this field';
                        } else {
                          checkFirstName = true;
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'First Name',
                      ),
                      onSaved: (value) {
                        firstNameUser = value!;
                      },
                    ),
                    TextFormField(
                      enabled: _Edit,
                      initialValue: lastNameUser,
                      enableSuggestions: false,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          checkLasttName = false;
                          return 'Please fill in this field';
                        } else {
                          checkLasttName = true;
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                      ),
                      onSaved: (value) {
                        lastNameUser = value!;
                      },
                    ),
                    TextFormField(
                      key: ValueKey('email'),
                      initialValue: emailUser,
                      enabled: _Edit,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          checkEmail = false;
                          return 'Please enter a valid email address.';
                        } else {
                          checkEmail = true;
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                      ),
                      onSaved: (value) {
                        emailUser = value!;
                      },
                    ),
                    TextFormField(
                      key: ValueKey('username'),
                      enabled: _Edit,
                      initialValue: userNameUser,
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
                        userNameUser = value!;
                      },
                    ),
                    TextFormField(
                      enabled: _Edit,
                      initialValue: ageUser,
                      enableSuggestions: false,
                      decoration: InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty || value.length > 3) {
                          checkAge = false;
                          return 'Please enter no more than 3 characters';
                        }
                        checkAge = true;
                        return null;
                      },
                      onSaved: (value) {
                        ageUser = value!;
                      },
                    ),
                    SizedBox(height: 12),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Color.fromARGB(255, 255, 255, 255),
                      child: Text(_Edit ? 'Save' : 'Edit'),
                      onPressed: () {
                        if (_Edit == true) {
                          _trySubmit();
                        }
                        if (checkAge == true &&
                            checkEmail == true &&
                            checkFirstName == true &&
                            checkLasttName == true &&
                            checkUserName == true) {
                          setState(() {
                            _Edit = !_Edit;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 12),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Color.fromARGB(255, 255, 255, 255),
                      child: Text('Weather'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/weather');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
