import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_ninja/common/normal_constants.dart';

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
  String address = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          allowLocation == true
              ? FlutterMap(
                  options: MapOptions(
                    // onTap: (q,latLng) async{
                    //   setState(() {
                    //     point = latLng;
                    //   });
                    //   final List<Placemark> placemarks =
                    //   await placemarkFromCoordinates(
                    //       latLng.latitude, latLng.longitude);
                    //   if (placemarks.isNotEmpty) {
                    //     final Placemark placemark = placemarks.first;
                    //     setState(() {
                    //       address =
                    //       "${placemark.subLocality},${placemark.locality}, ${placemark.country}";
                    //
                    //     });
                    //   } else {
                    //     setState(() {
                    //       address = "";
                    //     });
                    //   }
                    // },
                      center: LatLng(double.parse(NormalConstants.latitude),  double.parse(NormalConstants.longitude)), zoom: 15),
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
                            point: LatLng(double.parse(NormalConstants.latitude), double.parse(NormalConstants.longitude)),
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
          allowLocation == true?Padding(
            padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on_outlined),
                    hintText: "Search for location",
                    contentPadding: EdgeInsets.all(16)
                  ),
                )),
                Card(
                  child: Padding(padding: EdgeInsets.all(16),
                    child: Text(address,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                )
              ],
            ),
          ):Container(),

        ],
      ),
    );
  }
}
