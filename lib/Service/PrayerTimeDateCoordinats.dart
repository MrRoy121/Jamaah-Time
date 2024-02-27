import 'package:adhan_dart/adhan_dart.dart';
import 'package:location/location.dart';

class PrayerTimesUtil {
  static Future<PrayerTimes> getPrayerTimes() async {
    LocationData? currentLocation;
    Location location = Location();

    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      // Handle location fetching error
      print('Error fetching location: $e');
    }

    if (currentLocation != null) {
      Coordinates coordinates =
      Coordinates(currentLocation.latitude!, currentLocation.longitude!);

      DateTime date = DateTime.now();
      CalculationParameters params = CalculationMethod.Dubai();
      return PrayerTimes(coordinates, date, params, precision: true);
    } else {
      // Handle case where location is null
      return Future.error('Failed to fetch location');
    }
  }
}