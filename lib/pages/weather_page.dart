import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/Widgets/map_widget.dart';
import 'package:untitled/service/position_service.dart';
import 'package:untitled/service/weather_service.dart';
import '../Widgets/weather_forecast_widget.dart';
import '../Widgets/weather_info_widget.dart';
import '../models/weather_model.dart';



class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  Position? _position;
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  String? _cityName;
  List<Weather>? _dailyForecast;

   _fetchWeather() async {
     String cityName = await PositionService.getCurrentCity();
     final position = await PositionService.getCurrentPosition();

     try {
       final weather = await _weatherService.getCurrentWeather(position);
       //List<Weather> forecast = await _weatherService.getWeatherDailyForecast(position);
       setState(() {
         _weather = weather;
         _cityName = cityName;
         //_dailyForecast = forecast;
       });
     } catch (e) {
       //print(e);
     }
   }

  _fetchWeatherForecast() async {
    final position = await PositionService.getCurrentPosition();

    try {
      List<Weather>? forecast = await _weatherService.getWeatherDailyForecast(position);

      setState(() {
        _dailyForecast = forecast;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  _fetchPosition() async {
    try {
      final position = await PositionService.getCurrentPosition();
      setState(() {
        _position = position;
      });
    } catch (e) {
      //TODO
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    _fetchPosition();
    _fetchWeatherForecast();
  }

  @override
  Widget build(BuildContext context) {
     // if (_weather == null ) {
     //   return const Center(
     //     child: CircularProgressIndicator(),
     //   );
     // }
     return Scaffold(
      backgroundColor: HexColor('#06141B'),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu),),
            backgroundColor: HexColor("#06141B"),
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(100, 74, 92, 106),
                        Color.fromARGB(100, 6, 20, 27),
                      ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  )
                ),
              ),
              title: Text("$_cityName",
                style: TextStyle(
                  color: HexColor("#CCD0CF"),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${_weather?.temperature?.round()} C°",
                          style: TextStyle(
                              color: HexColor("#CCD0CF"),
                              fontWeight: FontWeight.bold,
                              fontSize: 26
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text("${_weather?.weatherCode}",
                          style: TextStyle(
                              color: HexColor("#CCD0CF"),
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text("${_position?.altitude.round()}m",
                          style: TextStyle(
                              color: HexColor("#CCD0CF"),
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text("${_dailyForecast?[0].tempMin} / ${_dailyForecast?[0].tempMax} feels like ${_weather?.apparentTemp?.round()}°", //TODO temp feels like
                          style: TextStyle(
                              color: HexColor("#CCD0CF"),
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                  ),
                  SizedBox(
                    width: 130,
                    child:
                    Lottie.asset(getWeatherAnimation(_weather?.weatherCode)),
                  )
                ],
              ),
            )
            ,
          ),
          weatherForecastWidget(_dailyForecast),
          weatherInfoWidget(_weather),
          mapWidget(_position),
        ],
      ),
    );
  }

  String getWeatherAnimation(int? mainCondition) {
    if (mainCondition == null) return 'assets/animations/sun.json';

    // switch (mainCondition) {
    //   case 'smoke':
    //   case 'mist':
    //   case 'clouds':
    //   case 'haze':
    //   case 'dust':
    //   case 'fog':
    //     return 'assets/animations/cloud.json';
    //   case 'rain':
    //   case 'drizzle':
    //   case 'shower rain':
    //     return 'assets/animations/rain.json';
    //   case 'thunderstorm':
    //     return 'assets/animations/thunderstorm.json';
    //   case 'clear':
    //     return 'assets/animations/sun.json';
    //   default: return 'assets/animations/sun.json';
    // }
    return 'assets/animations/sun.json';
  }

  // void _onRefresh() async {
  //   await Future.delayed(const Duration(milliseconds: 1000));
  //   _fetchWeather();
  //   _fetchPosition();
  //
  //   _refreshController.refreshCompleted();
  // }

  String getDay(final day) {
     DateTime time = DateTime.fromMicrosecondsSinceEpoch(day);
     final x = DateFormat('EEE').format(time);
     return x;
  }
}