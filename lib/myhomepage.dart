import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var lat;
var long;
bool allowLocation = false;
bool locationAllowed = false;
class _MyHomePageState extends State<MyHomePage> {
  LatLng point = LatLng(23.774475, 90.415871);

  _handleLocationPermission() async {
    bool serviceEnabled = false;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Give permission',
        textAlign: TextAlign.center,
      )));
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'To use KothaDialer Location Permission is required.',
          textAlign: TextAlign.center,
        )));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'To use KothaDialer required Location Permissions that are permanently denied.',
        textAlign: TextAlign.center,
      )));
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
      setState(() {
        locationAllowed = true;
        point = LatLng(position.latitude, position.longitude);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          allowLocation == true
              ? FlutterMap(
                  options: MapOptions(
                    onTap: (q,latLng){
                      setState(() {
                        point = latLng;
                        print("This is location ${latLng}");
                      });
                    },
                      center: LatLng(lat, long), zoom: 10),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                            width: 200,
                            height: 200,
                            point: LatLng(point.latitude, point.longitude),
                            builder: (ctx) => Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                              size: 40,
                                ))
                      ],
                    )
                  ],
                )
              : Center(
                  child: ElevatedButton(onPressed: (){
                    setState(() {
                      allowLocation = true;
                    });
                  }, child: Text("Press the button access map",
                  textAlign: TextAlign.center,
                  ))
                ),
        ],
      ),
    );
  }
}
