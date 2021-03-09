import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unitconverter/pressure_converter.dart';
import 'package:unitconverter/temperature_converter.dart';
import 'package:unitconverter/length_converter.dart';
import 'package:unitconverter/mass_converter.dart';
import 'package:unitconverter/volume_converter.dart';

class Converters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            elevation: 10.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            centerTitle: true,
            backgroundColor: Colors.red[900],
            title: Text(
              'Converters',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/home page background.jpg'),
                        fit: BoxFit.fill)),
                alignment: Alignment.center,
              ),
              IconSet()
            ],
          )),
    );
  }
}

class IconSet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(10.0),
                    width: 260.0,
                    height: 80.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.red[900], width: 2.0)),
                      splashColor: Colors.black,
                      color: Colors.grey[900],
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  TemperatureConverter(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  ScaleTransition(
                            alignment: Alignment.topCenter,
                            scale: CurvedAnimation(
                              parent: animation,
                              curve: Curves.elasticInOut,
                            ),
                            child: child,
                          ),
                          transitionDuration: Duration(milliseconds: 800),
                        ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.text_fields,
                            size: 50.0,
                            color: Colors.white,
                          ),
                          VerticalDivider(
                            indent: 10.0,
                            endIndent: 10.0,
                            thickness: 2.0,
                            width: 10.0,
                            color: Colors.red[900],
                          ),
                          Container(
                            width: 120.0,
                            child: Text(
                              'Temperature\nConverter',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.all(10.0),
                    width: 260.0,
                    height: 80.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.red[900], width: 2.0)),
                      splashColor: Colors.black,
                      color: Colors.grey[900],
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  LengthConverter(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  ScaleTransition(
                            alignment: Alignment.topCenter,
                            scale: CurvedAnimation(
                              parent: animation,
                              curve: Curves.elasticInOut,
                            ),
                            child: child,
                          ),
                          transitionDuration: Duration(milliseconds: 800),
                        ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.text_format,
                            size: 50.0,
                            color: Colors.white,
                          ),
                          VerticalDivider(
                            indent: 10.0,
                            endIndent: 10.0,
                            thickness: 2.0,
                            width: 10.0,
                            color: Colors.red[900],
                          ),
                          Container(
                            width: 120.0,
                            child: Text(
                              'Length\nConverter',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.all(10.0),
                    width: 260.0,
                    height: 80.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.red[900], width: 2.0)),
                      splashColor: Colors.black,
                      color: Colors.grey[900],
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  MassConverter(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  ScaleTransition(
                            alignment: Alignment.topCenter,
                            scale: CurvedAnimation(
                              parent: animation,
                              curve: Curves.elasticInOut,
                            ),
                            child: child,
                          ),
                          transitionDuration: Duration(milliseconds: 800),
                        ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.table_chart,
                            size: 50.0,
                            color: Colors.white,
                          ),
                          VerticalDivider(
                            indent: 10.0,
                            endIndent: 10.0,
                            thickness: 2.0,
                            width: 10.0,
                            color: Colors.red[900],
                          ),
                          Container(
                            width: 120.0,
                            child: Text(
                              'Mass\nConverter',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.all(10.0),
                    width: 260.0,
                    height: 80.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.red[900], width: 2.0)),
                      splashColor: Colors.black,
                      color: Colors.grey[900],
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  VolumeConverter(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  ScaleTransition(
                            alignment: Alignment.topCenter,
                            scale: CurvedAnimation(
                              parent: animation,
                              curve: Curves.elasticInOut,
                            ),
                            child: child,
                          ),
                          transitionDuration: Duration(milliseconds: 800),
                        ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.terrain,
                            size: 50.0,
                            color: Colors.white,
                          ),
                          VerticalDivider(
                            indent: 10.0,
                            endIndent: 10.0,
                            thickness: 2.0,
                            width: 10.0,
                            color: Colors.red[900],
                          ),
                          Container(
                            width: 120.0,
                            child: Text(
                              'Volume\nConverter',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.all(10.0),
                    width: 260.0,
                    height: 80.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.red[900], width: 2.0)),
                      splashColor: Colors.black,
                      color: Colors.grey[900],
                      onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                              PressureConverter(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                              ScaleTransition(
                                alignment: Alignment.topCenter,
                                scale: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.elasticInOut,
                                ),
                                child: child,
                              ),
                          transitionDuration: Duration(milliseconds: 800),
                        ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.equalizer,
                            size: 50.0,
                            color: Colors.white,
                          ),
                          VerticalDivider(
                            indent: 10.0,
                            endIndent: 10.0,
                            thickness: 2.0,
                            width: 10.0,
                            color: Colors.red[900],
                          ),
                          Container(
                            width: 120.0,
                            child: Text(
                              'Pressure\nConverter',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )),
              ]),
        ),
      ),
    );
  }
}
