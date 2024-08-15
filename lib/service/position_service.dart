import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class PositionService {
  Position? pos;

  static Future<Position> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  static Future<String> getCurrentCity() async {
    Position position = await PositionService.getCurrentPosition();

    List<Placemark> placeMark = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placeMark[0].locality;

    return city ?? "";
  }
}