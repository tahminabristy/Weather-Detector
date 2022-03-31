import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_applications/pages/weather_settings.dart';
import 'package:weather_applications/providers/weather_provider.dart';
import 'package:weather_applications/utils/constants.dart';
import 'package:weather_applications/utils/helper_functtion.dart';
import 'package:weather_applications/utils/style.dart';

class WeatherHomePage extends StatefulWidget {
  static const String routeName = '/current_weather_page';

  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  late WeatherProvider _provider;
  bool isItFirsttimeRun = true;

  @override
  void didChangeDependencies() {
    if(isItFirsttimeRun ==true){ //frst e dhukei method call holeo eita true tai line o execute o hobe, bt er por ar execute o hobe na hobe na ar tai line gulo execute o hobe na
      _provider= Provider.of<WeatherProvider>(context);
      refreshdata();
      isItFirsttimeRun=false;
    }

    super.didChangeDependencies();
  }


  void refreshdata(){
    getdata();

  }
  void getdata() async{
    final position =await determinePosition();
    _provider.getCurrentWeatherData(position.latitude,position.longitude);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(


        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.add) ),

        title: Center(child:  Text('Weather App',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold),)),
        actions: [IconButton(onPressed: () => Navigator.pushNamed(context, WeatherSettingsPage.routeName, arguments: refreshdata), icon: Icon(Icons.more_vert))],
      ),
      body: Stack(
       children: [
          Image.asset(
            'images/weatherImage.jpg',
            fit: BoxFit.cover,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
        buildColumnMethod()
        ],

        

      ),
    );
  }

  Center buildColumnMethod() {
    return Center(
          child: _provider.currentWeatherModel == null ? Center(child: CircularProgressIndicator()) : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  getdateFormatted(
                      _provider.currentWeatherModel!.dt!, 'EEE, MMM dd, yyyy'),
                  style: txtMin,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    '${_provider.currentWeatherModel!.name}, ${_provider.currentWeatherModel!.sys!.country} ',
                    style: txtMax),
                Text(
                  '${_provider.currentWeatherModel!.main!.temp!.round()}\u00B0',
                  style: txtTempBigStyle,
                ),
                Text(
                  'Feels like ${_provider.currentWeatherModel!.main!.feelsLike!.round()}\u00B0',
                  style: txtMax,
                ),
                Text('${_provider.currentWeatherModel!.weather![0].description}',style: txtMax,),
               Image.network('$icon_preffix${_provider.currentWeatherModel!.weather![0].icon}$icon_suffix')
               // Text('Sunrise : $getdateFormatted(${_provider.currentWeatherModel!.sys!.sunrise}, hh,mm')
              ],
            ),
          ),
        );
  }
}
