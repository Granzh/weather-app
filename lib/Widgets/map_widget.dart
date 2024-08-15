import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

Widget mapWidget(Position? position) {
  return SliverToBoxAdapter (
      child: Container(
          height: 300,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 7),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: HexColor("#11212D"),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Map",
                style: TextStyle(
                    color: HexColor("#CCD0CF"),
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 240,
                child: FlutterMap(
                  options:  MapOptions(
                    initialCenter: LatLng(position?.latitude ?? 51.5, position?.longitude ?? -2.09),
                    initialZoom: 10,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
      )
    );
}