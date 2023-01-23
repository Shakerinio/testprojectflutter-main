import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_project/widgets/weather.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  void _submitWeatherForm(
    String city,
    String temperature,
    bool weather_state,
    BuildContext ctx,
  ) async {}

  bool weather_state = true;
  String city = '2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Weather'),
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
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance
                    .signOut()
                    .then((value) => Navigator.pushNamed(context, '/login'));
              }
            },
          ),
        ],
      ),
      body: WeatherWidget(_submitWeatherForm),
    );
  }
}
