import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {

  WeatherService();

  Future<Weather> getCurrentWeather(Position position) async {
    final lat = position.latitude;
    final lon = position.longitude;
    final response = await http.get(Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset&timeformat=unixtime&timezone=auto'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);
      Map<String, dynamic> current = jsonBody['current'];
      return Weather(
        date: _unpackDate(current, 'time'),
        temperature: _unpackDouble(current, 'temperature_2m'),
        weatherCode: _unpackInt(current, 'weather_code'),
        tempMax: 0,
        tempMin: 0,
        humidity: _unpackInt(current, 'relative_humidity_2m'),
        windSpeed: _unpackDouble(current, 'wind_speed_10m'),
        apparentTemp: _unpackDouble(current, 'apparent_temperature'),
        pressure: _unpackDouble(current, 'surface_pressure'),
      );
    } else {
      throw Exception('failed to load weather data');
    }
  }

  Future<List<Weather>> getWeatherDailyForecast(Position position) async {
    final lat = position.latitude;
    final lon = position.longitude;
    final response = await http.get(Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset&timeformat=unixtime&timezone=auto'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);
      Map<String, dynamic> daily = jsonBody['daily'];
      List<Weather> forecast = [];
      List<int> weatherCodes = List<int>.from(daily['weather_code']);
      List<double> tempMin = _unpackDoubleList(daily, 'temperature_2m_min');
      List<double> tempMax = _unpackDoubleList(daily, 'temperature_2m_max');
      for (int i = 0; i < 7; i++) {
        forecast.add(
            Weather(
              date: DateTime.now(),
              temperature: 0,
              weatherCode: weatherCodes[i],
              tempMax: tempMax[i],
              tempMin: tempMin[i],
              humidity: -1,
              windSpeed: -1,
              apparentTemp: 0,
              pressure: -1,
          )
        );
      }
      return forecast;
    } else {
      throw Exception();
    }
  }
}

int? _unpackInt(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      final val = M[k];
      if (val is String) {
        return int.parse(val);
      } else if (val is int) {
        return val;
      }
      return -1;
    }
  }
  return null;
}

double? _unpackDouble(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      final val = M[k];
      if (val is String) {
        return double.parse(val);
      } else if (val is num) {
        return val.toDouble();
      }
    }
  }
  return null;
}

String? _unpackString(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      return M[k];
    }
  }
  return null;
}

DateTime? _unpackDate(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      int millis = M[k] * 1000;
      return DateTime.fromMillisecondsSinceEpoch(millis);
    }
  }
  return null;
}

List<double> _unpackDoubleList(Map<String, dynamic> M, String k) {
  return M[k];
}