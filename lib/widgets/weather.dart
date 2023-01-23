import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_project/utils/globals.dart';

class WeatherWidget extends StatefulWidget {
  WeatherWidget(
    this.submitFn,
  );
  final void Function(
    String city,
    String temperature,
    bool weather_state,
    BuildContext ctx,
  ) submitFn;

  @override
  State<WeatherWidget> createState() => _WeatherScreen();
}

class _WeatherScreen extends State<WeatherWidget> {
  final _formKey = GlobalKey<FormState>();
  var city;
  var temperature;
  var cityName;
  var weather_state = false;
  var cityNameState = false;

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter city name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'City'),
                    onChanged: (text) {
                      city = text;
                      if (city.toString().isNotEmpty) {
                      } else {}
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              FlatButton(
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: Text('Show the weather'),
                onPressed: () async {
                  _trySubmit();
                  final response = await http.post(Uri.parse(
                      'https://api.openweathermap.org/data/2.5/weather?q=$city&lat=&lon=&appid=$apiKey&units=metric'));

                  if (response.statusCode == 200) {
                    weather_state = false;
                    var jsonResponse = json.decode(response.body);
                    cityName = jsonResponse['name'];
                    temperature =
                        double.parse(jsonResponse['main']['temp'].toString())
                            .toInt();
                  } else if (response.statusCode == 400 ||
                      response.statusCode == 404) {
                    weather_state = false;
                  }
                  setState(() {
                    if (response.statusCode == 200) {
                      weather_state = true;
                      cityNameState = false;
                    } else if (response.statusCode == 400 ||
                        response.statusCode == 404) {
                      weather_state = false;
                      cityNameState = true;
                    }
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (cityNameState)
                Text(
                  'Wrong city name ',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              if (weather_state)
                Text(
                  '$cityName',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              if (weather_state)
                Text(
                  '$temperature' + '°',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
