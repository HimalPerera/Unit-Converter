import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage(),
          settings: RouteSettings(
            name: '/homepage'
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(
                  'images/splash_screen_new.jpg',
                  fit: BoxFit.fill,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/logo_new.png',
                      scale: 3.5,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Shimmer.fromColors(
                        child: Text(
                          'Unit Converter',
                          style: TextStyle(
                              fontSize: 35.0,
                              color: Colors.white,
                              fontFamily: 'Patua_One',
                              letterSpacing: 1.5),
                        ),
                        baseColor: Colors.white,
                        highlightColor: Colors.red)
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
