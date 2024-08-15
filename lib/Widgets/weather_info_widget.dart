import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../models/weather_model.dart';

Widget weatherInfoWidget(Weather? weather) {
  return
    SliverToBoxAdapter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 130,
                    margin: const EdgeInsets.fromLTRB(20, 3, 3, 3),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: HexColor("#11212D"),
                    ),
                    child: Column(
                      children: [
                        Image.asset("assets/icons/pressure.png", width: 50,),
                        Text("Pressure", style: TextStyle(
                            color: HexColor("#CCD0CF"),
                            fontWeight: FontWeight.bold
                        ), textAlign: TextAlign.center,),
                        Text(
                            "${weather?.pressure} KPa",
                            style: TextStyle(
                                color: HexColor("#9BA8AB")
                            )
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 130,
                    margin: const EdgeInsets.fromLTRB(2, 3, 20, 3),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: HexColor("#11212D"),
                    ),
                    child: Column(
                      children: [
                        Image.asset("assets/icons/humidity.png", width: 50,),
                        Text("Humidity", style: TextStyle(
                            color: HexColor("#CCD0CF"),
                            fontWeight: FontWeight.bold
                        ), textAlign: TextAlign.center,),
                        Text(
                            "${weather?.humidity}%",
                            style: TextStyle(
                                color: HexColor("#9BA8AB")
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child:
                Container(
                  height: 130,
                  margin: const EdgeInsets.fromLTRB(20, 3, 3, 3),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: HexColor("#11212D"),
                  ),
                  child: Column(
                    children: [
                      Image.asset("assets/icons/wind.png", width: 50,),
                      Text("Wind", style: TextStyle(
                          color: HexColor("#CCD0CF"),
                          fontWeight: FontWeight.bold
                      ), textAlign: TextAlign.center,),
                      Text("${weather?.windSpeed} km/h", style: TextStyle(
                          color: HexColor("#9BA8AB")
                      ),)
                    ],
                  ),
                ),
                ),
                Expanded(child:
                Container(
                  height: 130,
                  margin: const EdgeInsets.fromLTRB(2, 3, 20, 3),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: HexColor("#11212D"),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/icons/sunrise.png", width: 50,),
                            Text("Sunrise", style: TextStyle(
                                color: HexColor("#CCD0CF"),
                                fontWeight: FontWeight.bold
                            ), textAlign: TextAlign.center,),
                            // Text("${weather?.sunrise?.hour}:${weather?.sunrise?.minute}", style: TextStyle(
                            //     color: HexColor("#9BA8AB")
                            // ))
                          ],
                        ),
                      ),
                      Expanded(
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/icons/sunset.png", width: 50,),
                            Text("Sunset", style: TextStyle(
                                color: HexColor("#CCD0CF"),
                                fontWeight: FontWeight.bold
                            ), textAlign: TextAlign.center,),
                            // Text("${weather?.sunset?.hour}:${weather?.sunset?.minute}", style: TextStyle(
                            //     color: HexColor("#9BA8AB")
                            // )
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ),
              ],
            )
          ],
        )
    );
}