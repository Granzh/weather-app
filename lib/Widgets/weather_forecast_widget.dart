import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../models/weather_model.dart';


Widget weatherForecastWidget(List<Weather>? weatherForecast) {
  return
    SliverToBoxAdapter(
      child: Container(
        height: 400,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 7),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: HexColor("#11212D"),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Next Days",
                  style: TextStyle(
                      color: HexColor("#CCD0CF"),
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            SizedBox(
              height: 330,
              child: ListView.builder(
                itemCount: weatherForecast?.length ?? 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 60,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(DateFormat('EEE').format(weatherForecast?[index].date ?? DateTime(2024, 8 ,6)),
                            style: TextStyle(
                                color: HexColor("#CCD0CF"),
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset("assets/icons/sunny.png")
                        ),
                        SizedBox(
                          width: 30,
                          child: Text("${weatherForecast?[index].tempMin}",
                            style: TextStyle(
                                color: HexColor("#CCD0CF"),
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: Text("${weatherForecast?[index].tempMax}",
                            style: TextStyle(
                                color: HexColor("#CCD0CF"),
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
}