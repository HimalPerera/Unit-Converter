import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unitconverter/converters.dart';
import 'package:unitconverter/formulas_page.dart';

class HomePage extends StatelessWidget {
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            centerTitle: true,
            backgroundColor: Colors.red[900],
            title: Text(
              'Home Page',
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
                    width: 150.0,
                    height: 150.0,
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
                                  Converters(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                  begin: Offset(0.0, -1.0), end: Offset.zero),
                            ),
                            child: child,
                          ),
                          transitionDuration: Duration(milliseconds: 200),
                        ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.cached,
                            size: 100,
                            color: Colors.white,
                          ),
                          Divider(
                            thickness: 2.0,
                            height: 10.0,
                            color: Colors.red[900],
                          ),
                          Text(
                            'Converters',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                SizedBox(height: 10.0,),
                Container(
                    margin: EdgeInsets.all(10.0),
                    width: 150.0,
                    height: 150.0,
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
                              FormulasPage(),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.code,
                            size: 100,
                            color: Colors.white,
                          ),
                          Divider(
                            thickness: 2.0,
                            height: 10.0,
                            color: Colors.red[900],
                          ),
                          Text(
                            'Formulas',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
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
