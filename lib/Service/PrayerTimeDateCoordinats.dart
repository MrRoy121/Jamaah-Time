import 'package:adhan_dart/adhan_dart.dart';
import 'package:location/location.dart';

class PrayerTimesUtil {
  static Future<PrayerTimes> getPrayerTimes() async {
    LocationData? currentLocation;
    Location location = Location();

    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      print('Error fetching location: $e');
    }

    if (currentLocation != null) {
      Coordinates coordinates =
      Coordinates(currentLocation.latitude!, currentLocation.longitude!);

      DateTime date = DateTime.now();
      CalculationParameters params = CalculationMethod.MuslimWorldLeague();
      params.madhab=Madhab.Hanafi;
      return PrayerTimes(coordinates, date, params, precision: true);
    } else {
      return Future.error('Failed to fetch location');
    }
  }
}