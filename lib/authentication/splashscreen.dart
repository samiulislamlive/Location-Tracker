

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location_ninja/authentication/login_page.dart';
import 'package:location_ninja/common/normal_constants.dart';
import 'package:location_ninja/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

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
