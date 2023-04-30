


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_ninja/common/normal_constants.dart';
import 'package:location_ninja/main.dart';
import 'package:location_ninja/myhomepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool submit = false;
  final _formKey = GlobalKey<FormState>();

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

  bool checkRegister(){
    submit = _emailController.text.isEmpty || _passwordController.text.isEmpty;
    return submit;
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
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: mq.height * 0.5,
          width: mq.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
              border: Border.all(
                color: Colors.blue,
                width: mq.width * 0.001
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                offset: Offset(10, 10),
                blurRadius: 5,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Image(image: AssetImage(NormalConstants.image1),
                height: mq.height * 0.1,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(NormalConstants.purpleBlueColor)
                        ),
                        onPressed: checkRegister() ? (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                        }:null,
                        child: Text('Log In',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
