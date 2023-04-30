

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_ninja/authentication/login_page.dart';
import 'package:location_ninja/common/normal_constants.dart';
import 'package:location_ninja/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

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
    NormalConstants.latitude = position.latitude;
    NormalConstants.longitude = position.longitude;
    print("lat from splash ${NormalConstants.latitude}");
    print("long from splash ${NormalConstants.longitude}");
  }

  navigateTo() async {
    Timer(const Duration(milliseconds: 2000), () {
      if(mounted){
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => LoginPage()
            ),
                (route) => false);
      }
    }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleLocationPermission();
    navigateTo();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: mq.height,
        width: mq.width,
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Colors.lightGreen,
        //         Colors.white,
        //       ],
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomLeft,
        //     )
        // ),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    NormalConstants.image1,
                    width: mq.width * 0.7,
                  ),
                  SizedBox(height: mq.height * 0.1,),
                  const CircularProgressIndicator(
                    color: Color(NormalConstants.purpleBlueColor),
                  ),
                ],
              ),
            ),
            Align(
                alignment: const Alignment(0.0, 0.8),
                child: Text("Developed by BDCOM Online LTD.",
                  style: TextStyle(
                      color: Color(NormalConstants.purpleBlueColor),
                      fontSize: mq.height * 0.02,
                      fontWeight: FontWeight.bold
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
