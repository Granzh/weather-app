import 'package:flutter/cupertino.dart';
import '../models/weather_model.dart';

Widget weatherHourlyForecastWidget(List<Weather>? hourly) {
  return SliverToBoxAdapter(
    child: Column(
      children: [
        Container(
          height: 150,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: ListView.builder(
            itemCount: (hourly?.length ?? 12) > 12 ? 12 : hourly?.length,
            itemBuilder: (context, index) {
              return Container(

              );
            },
          ),
        )
      ],
    )
  );
}