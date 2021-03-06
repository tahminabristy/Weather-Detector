import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
String getdateFormatted(int dt,String format){
  return DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(dt*1000)); //1000 gun kore milite cnvert kore datetime er obj e pass kore , theen j formate asbe oita dateformate formate korbe jeta amra parameter hisebe pass korbo
}
Future<bool> setfahrenheitStatus(bool status) async{
  final preference= await SharedPreferences.getInstance();
  return preference.setBool('status', status);
}
Future<bool> getfahrenheitStatus() async{
  final preferece= await SharedPreferences.getInstance();
  return preferece.getBool('status') ?? false;
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}