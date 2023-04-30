import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_ninja/common/normal_constants.dart';
import 'package:location_ninja/main.dart';

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

  double? touchLat;
  double? touchLong;

  getExactPosition(double lat, double long,LatLng position) async{
    List<Placemark> placemarks =
    await placemarkFromCoordinates(lat, long);
    Placemark placemark = placemarks[0];
    String city = placemark.locality ?? '';
    String country = placemark.country ?? '';
    String sub = placemark.subLocality ?? '';
    String admin = placemark.administrativeArea ?? '';
    String subadmin = placemark.subAdministrativeArea ?? '';
    String street = placemark.street ?? '';
    bottomSheet(city, country,sub,admin,subadmin,street, lat, long, position);
  }

  bottomSheet(String city,String country,String sub,String admin,String subadmin,String street, double lat, double long, var position){
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: mq.height * 0.5,
          child: Column(
            children: [
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                  vertical: mq.height * 0.015,
                  horizontal: mq.width * 0.4,
                ),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
              SizedBox(height: mq.height * 0.025,),
              Text("Street: ${street}",
                style: TextStyle(
                    fontSize: mq.height * 0.022
                ),
              ),
              Text("Area ${sub}",
                style: TextStyle(
                    fontSize: mq.height * 0.022
                ),),
              Text("City: ${city}",
                style: TextStyle(
                    fontSize: mq.height * 0.022
                ),),
              Text("Country: ${country}",
                style: TextStyle(
                    fontSize: mq.height * 0.022
                ),),
              Text("Save this location as?",
                style: TextStyle(
                    fontSize: mq.height * 0.024,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(height: mq.height * 0.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      MaterialButton(onPressed: () async{
                        // await controller.addMarker(position, markerIcon: MarkerIcon(
                        //   icon: Icon(Icons.home, color: Colors.black, size: 48,),
                        // ),
                        // );
                        // key = '${position.latitude}_${position.longitude}';
                        // markerMap[key] = markerMap.length.toString();
                        // Navigator.pop(context);
                      }, child: Icon(Icons.home),padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                        color: Colors.white,
                      ),
                      Text("Home",
                        style: TextStyle(
                          fontSize: mq.height * 0.023,
                        ),),
                    ],
                  ),
                  Column(
                    children: [
                      MaterialButton(onPressed: () async{
                        // await controller.addMarker(position, markerIcon: MarkerIcon(
                        //   icon: Icon(Icons.apartment, color: Colors.black, size: 48,),
                        // ),);
                        // key = '${position.latitude}_${position.longitude}';
                        // markerMap[key] = markerMap.length.toString();
                        // Navigator.pop(context);
                      }, child: Icon(Icons.apartment),padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                        color: Colors.white,),
                      Text("Office",
                        style: TextStyle(
                          fontSize: mq.height * 0.023,
                        ),),
                    ],
                  ),
                  Column(
                    children: [
                      MaterialButton(onPressed: () async{
                        // await controller.addMarker(position, markerIcon: MarkerIcon(
                        //   icon: Icon(Icons.shop, color: Colors.black, size: 48,),
                        // ),);
                        // key = '${position.latitude}_${position.longitude}';
                        // markerMap[key] = markerMap.length.toString();
                        // Navigator.pop(context);
                      }, child: Icon(Icons.shop),padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                        color: Colors.white,),
                      Text("Mall",
                        style: TextStyle(
                          fontSize: mq.height * 0.023,
                        ),),
                    ],
                  ),
                  Column(
                    children: [
                      MaterialButton(onPressed: () async{
                        // await controller.addMarker(position, markerIcon: MarkerIcon(
                        //   icon: Icon(Icons.local_hospital, color: Colors.black, size: 48,),
                        // ),);
                        // key = '${position.latitude}_${position.longitude}';
                        // markerMap[key] = markerMap.length.toString();
                        // Navigator.pop(context);
                      }, child: Icon(Icons.local_hospital),padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                        color: Colors.white,),
                      Text("Hospital",
                        style: TextStyle(
                          fontSize: mq.height * 0.023,
                        ),),
                    ],
                  ),
                ],
              ),
              // Add more list tiles or widgets as needed
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              onTap: (q,latlng) async{
                setState(() {
                  touchLat = latlng.latitude;
                  touchLong = latlng.longitude;
                });
                getExactPosition(touchLat!, touchLong!, latlng);
              },
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
                center: LatLng(double.parse(NormalConstants.latitude),
                    double.parse(NormalConstants.longitude)),
                zoom: 15),
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
                      point: LatLng(double.parse(NormalConstants.latitude),
                          double.parse(NormalConstants.longitude)),
                      builder: (ctx) => Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ))
                ],
              )
            ],
          ),
          ///commented out the textfield
          // allowLocation == true
          //     ? Padding(
          //         padding:
          //             const EdgeInsets.symmetric(vertical: 34, horizontal: 16),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Card(
          //                 child: TextField(
          //               decoration: InputDecoration(
          //                   prefixIcon: Icon(Icons.location_on_outlined),
          //                   hintText: "Search for location",
          //                   contentPadding: EdgeInsets.all(16)),
          //             )),
          //             Card(
          //               child: Padding(
          //                 padding: EdgeInsets.all(16),
          //                 child: Text(
          //                   address,
          //                   style: TextStyle(fontWeight: FontWeight.bold),
          //                 ),
          //               ),
          //             )
          //           ],
          //         ),
          //       )
          //     : Container(),

        ],
      ),
    );
  }
}
