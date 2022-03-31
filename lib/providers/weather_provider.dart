import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weather_applications/models/current_weather_model.dart';
import 'package:http/http.dart' as Http;
import 'package:weather_applications/utils/helper_functtion.dart';

class WeatherProvider extends ChangeNotifier{
  CurrentWeatherModel? currentWeatherModel;


  void getCurrentWeatherData(double lat, double lng) async{
    final status= await getTempStatus();
    final units= status ? 'imperial' : 'metric' ;

    final Uri uri = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&units=$units&appid=7ef3bc816c4038e826c2b33d842e96ec');

    try{
      final response =await Http.get(uri);
      if (response.statusCode==200){
        final map= json.decode(response.body);
        currentWeatherModel= CurrentWeatherModel.fromJson(map);
        print(currentWeatherModel!.main!.temp);
        notifyListeners();
      }
    }
    catch(e){
      throw e;
    }
  }

  Future<bool> getTempStatus() => getfahrenheitStatus();

}