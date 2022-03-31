import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_applications/pages/current_weather_home.dart';
import 'package:weather_applications/pages/weather_settings.dart';
import 'package:weather_applications/providers/weather_provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=> WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
            fontFamily: 'DancingScript',
            primarySwatch: Colors.teal,
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white
          ),

        ),
        home:WeatherHomePage(),
        routes: {
          WeatherSettingsPage.routeName: (context)=>WeatherSettingsPage(),
          WeatherHomePage.routeName: (context)=>WeatherHomePage(),

        },
      ),
    );
  }
}
