import 'package:flutter/material.dart';
import 'package:weather_applications/utils/helper_functtion.dart';

class WeatherSettingsPage extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  _WeatherSettingsPageState createState() => _WeatherSettingsPageState();
}

class _WeatherSettingsPageState extends State<WeatherSettingsPage> {
  late bool switchtilevalue;
  late Function refreshFunction;
  @override
  void initState() {
    getfahrenheitStatus().then((value) {
      setState(() {
        switchtilevalue=value;

      });
    }
    );
    super.initState();
  }
  @override
  void didChangeDependencies() {
  refreshFunction= ModalRoute.of(context)!.settings.arguments as  Function;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(child:  Text('Weather App',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold),)),

      ),
      body: Stack(
        children: [
          Image.asset(
            'images/weatherImage.jpg',
            fit: BoxFit.cover,
            width: double.maxFinite,
            height: double.maxFinite,
          ),

          SafeArea(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //SizedBox(height: 30,),
                  SwitchListTile(
                    title: Text('Show tempereture in Fahrenheit'),
                      subtitle: Text('Default is Celsius'),
                      value: switchtilevalue,
                      onChanged:(value) async{
                      setState(() {
                        switchtilevalue=value;
                      });
                      await setfahrenheitStatus(switchtilevalue);
                      refreshFunction();
                      }
                  )
                ],
              ),
          ),
        ],
      ),
    );
  }
}
