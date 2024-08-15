class Weather {
  final double? temperature;
  final double? tempMin;
  final double? tempMax;
  final int? weatherCode;
  final DateTime? date;
  final double? windSpeed;
  final int? humidity;
  final double? apparentTemp;
  final double? pressure;

  Weather({
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.weatherCode,
    required this.date,
    required this.windSpeed,
    required this.humidity,
    required this.apparentTemp,
    required this.pressure,
  });

  static String getDayOfWeek(DateTime dateTime) {
    List<String> days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    return days[dateTime.weekday % 7];
  }
}
