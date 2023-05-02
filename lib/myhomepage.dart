import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_ninja/common/normal_constants.dart';
import 'package:location_ninja/main.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool allowLocation = false;
bool locationAllowed = false;
bool drawerOpen = false;

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String address = "";

  double? touchLat;
  double? touchLong;

  List<Marker> _markers = [];

  List<LatLng> _points = [];

  MapController _mapController = MapController();

  late LatLng _startPoint;
  late LatLng _endPoint;

  getExactPosition(double lat, double long, LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark placemark = placemarks[0];
    String city = placemark.locality ?? '';
    String country = placemark.country ?? '';
    String sub = placemark.subLocality ?? '';
    String admin = placemark.administrativeArea ?? '';
    String subadmin = placemark.subAdministrativeArea ?? '';
    String street = placemark.street ?? '';
    bottomSheet(
        city, country, sub, admin, subadmin, street, lat, long, position);
  }

  getMarkerPos(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String city = placemark.locality ?? '';
    String country = placemark.country ?? '';
    String sub = placemark.subLocality ?? '';
    String admin = placemark.administrativeArea ?? '';
    String subadmin = placemark.subAdministrativeArea ?? '';
    String street = placemark.street ?? '';
    _showLocationInfoDialog(city, country, sub, admin, subadmin, street,
        position.latitude, position.longitude, position);
  }

  bottomSheet(String city, String country, String sub, String admin,
      String subadmin, String street, double lat, double long, var position) {
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
              SizedBox(
                height: mq.height * 0.025,
              ),
              Text(
                "Street: ${street}",
                style: TextStyle(fontSize: mq.height * 0.022),
              ),
              Text(
                "Area ${sub}",
                style: TextStyle(fontSize: mq.height * 0.022),
              ),
              Text(
                "City: ${city}",
                style: TextStyle(fontSize: mq.height * 0.022),
              ),
              Text(
                "Country: ${country}",
                style: TextStyle(fontSize: mq.height * 0.022),
              ),
              Text(
                "Save this location as?",
                style: TextStyle(
                    fontSize: mq.height * 0.024, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: mq.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          setState(() {
                            _markers.add(
                              Marker(
                                width: mq.width * 0.1,
                                height: mq.height * 0.05,
                                point: LatLng(lat, long),
                                builder: (ctx) => GestureDetector(
                                  child: Icon(
                                    Icons.home,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    getMarkerPos(LatLng(lat, long));
                                  },
                                ),
                              ),
                            );
                          });
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.home),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                        color: Colors.white,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          fontSize: mq.height * 0.023,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          setState(() {
                            _markers.add(
                              Marker(
                                width: mq.width * 0.1,
                                height: mq.height * 0.05,
                                point: LatLng(lat, long),
                                builder: (ctx) => GestureDetector(
                                  child: Icon(
                                    Icons.apartment,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    getMarkerPos(LatLng(lat, long));
                                  },
                                ),
                              ),
                            );
                          });
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.apartment),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                        color: Colors.white,
                      ),
                      Text(
                        "Office",
                        style: TextStyle(
                          fontSize: mq.height * 0.023,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          setState(() {
                            _markers.add(
                              Marker(
                                width: mq.width * 0.1,
                                height: mq.height * 0.05,
                                point: LatLng(lat, long),
                                builder: (ctx) => GestureDetector(
                                  child: Icon(
                                    Icons.local_mall,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    getMarkerPos(LatLng(lat, long));
                                  },
                                ),
                              ),
                            );
                          });
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.local_mall),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                        color: Colors.white,
                      ),
                      Text(
                        "Mall",
                        style: TextStyle(
                          fontSize: mq.height * 0.023,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          setState(() {
                            _markers.add(
                              Marker(
                                width: mq.width * 0.1,
                                height: mq.height * 0.05,
                                point: LatLng(lat, long),
                                builder: (ctx) => GestureDetector(
                                  child: Icon(
                                    Icons.local_hospital,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    getMarkerPos(LatLng(lat, long));
                                  },
                                ),
                              ),
                            );
                          });
                          Navigator.pop(context);
                          // await controller.addMarker(position, markerIcon: MarkerIcon(
                          //   icon: Icon(Icons.local_hospital, color: Colors.black, size: 48,),
                          // ),);
                          // key = '${position.latitude}_${position.longitude}';
                          // markerMap[key] = markerMap.length.toString();
                          // Navigator.pop(context);
                        },
                        child: Icon(Icons.local_hospital),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                        color: Colors.white,
                      ),
                      Text(
                        "Hospital",
                        style: TextStyle(
                          fontSize: mq.height * 0.023,
                        ),
                      ),
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

  final polylinePoints = [];

  void _showLocationInfoDialog(
      String city,
      String country,
      String sub,
      String admin,
      String subadmin,
      String street,
      double lat,
      double long,
      LatLng position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Marker Point Location."),
          content: Container(
            height: mq.height * 0.2,
            child: Column(
              children: [
                Container(
                  height: 4,
                  margin: EdgeInsets.symmetric(
                    vertical: mq.height * 0.015,
                    horizontal: mq.width * 0.4,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  height: mq.height * 0.025,
                ),
                Text(
                  "Street: ${street}",
                  style: TextStyle(fontSize: mq.height * 0.022),
                ),
                Text(
                  "Area ${sub}",
                  style: TextStyle(fontSize: mq.height * 0.022),
                ),
                Text(
                  "City: ${city}",
                  style: TextStyle(fontSize: mq.height * 0.022),
                ),
                Text(
                  "Country: ${country}",
                  style: TextStyle(fontSize: mq.height * 0.022),
                ),
                // Add more list tiles or widgets as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _markers.removeWhere((marker) => marker.point == position);
                });
                Navigator.pop(context);
              },
              child: Text('Remove Marker'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _markers.removeWhere((marker) => marker.point == position);
                });
                Navigator.pop(context);
              },
              child: Text('Get directions'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(Marker(
        width: mq.width * 0.1,
        height: mq.height * 0.05,
        point: LatLng(NormalConstants.latitude, NormalConstants.longitude),
        builder: (ctx) => Icon(
              Icons.location_on,
              color: Colors.red,
              size: 30,
            )));
  }

  bool _isCheckedGreen = false;
  bool _isCheckedBlue = false;
  bool _isCheckedRed = false;

  bool car11 = false;
  bool car12 = false;
  bool car13 = false;

  bool car21 = false;
  bool car22 = false;
  bool car23 = false;

  bool car31 = false;
  bool car32 = false;
  bool car33 = false;

  List<LatLng> points = [
    LatLng(37.7749, -122.4194),
    LatLng(40.7128, -74.0060),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme.primary;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: mq.height * 0.1,
            ),
            Row(
              children: [
                Checkbox(
                  value: _isCheckedGreen,
                  onChanged: (value) {
                    setState(() {
                      _isCheckedGreen = value!;
                    });
                  },
                  activeColor: Colors.green,
                ),
                Text("BDCOM Online Limited"),
              ],
            ),
            _isCheckedGreen
                ? Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * 0.1,
                          ),
                          Checkbox(
                            value: car11,
                            onChanged: (value) {
                              setState(() {
                                car11 = value!;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Text("Car1"),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * 0.1,
                          ),
                          Checkbox(
                            value: car12,
                            onChanged: (value) {
                              setState(() {
                                car12 = value!;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Text("Car2"),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * 0.1,
                          ),
                          Checkbox(
                            value: car13,
                            onChanged: (value) {
                              setState(() {
                                car13 = value!;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Text("Car3"),
                        ],
                      ),
                    ],
                  )
                : Container(),
            Row(
              children: [
                Checkbox(
                  value: _isCheckedBlue,
                  onChanged: (value) {
                    setState(() {
                      _isCheckedBlue = value!;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                Text("VTS Team"),
              ],
            ),
            _isCheckedBlue
                ? Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * 0.1,
                          ),
                          Checkbox(
                            value: car21,
                            onChanged: (value) {
                              setState(() {
                                car21 = value!;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text("Car1"),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * 0.1,
                          ),
                          Checkbox(
                            value: car22,
                            onChanged: (value) {
                              setState(() {
                                car22 = value!;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text("Car2"),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * 0.1,
                          ),
                          Checkbox(
                            value: car23,
                            onChanged: (value) {
                              setState(() {
                                car23 = value!;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text("Car3"),
                        ],
                      ),
                    ],
                  )
                : Container(),
            Row(
              children: [
                Checkbox(
                  value: _isCheckedRed,
                  onChanged: (value) {
                    setState(() {
                      _isCheckedRed = value!;
                    });
                  },
                  activeColor: Colors.red,
                ),
                Text("Nijam Uddin"),
              ],
            ),
            _isCheckedRed
                ? Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * 0.1,
                          ),
                          Checkbox(
                            value: car31,
                            onChanged: (value) {
                              setState(() {
                                car31 = value!;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text("Car1"),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * 0.1,
                          ),
                          Checkbox(
                            value: car32,
                            onChanged: (value) {
                              setState(() {
                                car32 = value!;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text("Car2"),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: mq.width * 0.1,
                          ),
                          Checkbox(
                            value: car33,
                            onChanged: (value) {
                              setState(() {
                                car33 = value!;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text("Car3"),
                        ],
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
                onTap: (q, latlng) async {
                  setState(() {
                    touchLat = latlng.latitude;
                    touchLong = latlng.longitude;
                  });
                  print("touched lat ${touchLat}");
                  print("touched long ${touchLong}");
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
                center:
                    LatLng(NormalConstants.latitude, NormalConstants.longitude),
                zoom: 50),
            children: [
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: points,
                    strokeWidth: 4,
                    color: Colors.blue,
                  )
                ],
              ),
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: _markers,
              )
            ],
          ),
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
          ///commented out the textfield

          Align(
            alignment: Alignment(0.9, 0.7),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: mq.height * 0.04,
              child: IconButton(
                onPressed: () {
                  _mapController.move(
                      _mapController.center, _mapController.zoom + 1);
                },
                icon: Icon(
                  Icons.zoom_in,
                  size: mq.height * 0.05,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.9, 0.9),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: mq.height * 0.04,
              child: IconButton(
                onPressed: () {
                  _mapController.move(
                      _mapController.center, _mapController.zoom - 1);
                },
                icon: Icon(
                  Icons.zoom_out_sharp,
                  size: mq.height * 0.05,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.9, -0.8),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: mq.height * 0.03,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.layers,
                  size: mq.height * 0.03,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.9, -0.65),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: mq.height * 0.03,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _mapController.move(
                        LatLng(NormalConstants.latitude,
                            NormalConstants.longitude),
                        15);
                  });
                },
                icon: Icon(
                  Icons.restart_alt,
                  size: mq.height * 0.03,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.9, -0.5),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: mq.height * 0.03,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.directions,
                  size: mq.height * 0.03,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.9, -0.8),
            child: InkWell(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                height: mq.height * 0.05,
                width: mq.width * 0.11,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: mq.height * 0.03,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
