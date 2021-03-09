import 'package:flutter/material.dart';

class TemperatureFormulasBody extends StatefulWidget {
  @override
  _TemperatureFormulasBodyState createState() =>
      _TemperatureFormulasBodyState();
}

class _TemperatureFormulasBodyState extends State<TemperatureFormulasBody> {
  var _fromUnits = ['Celsius', 'Fahrenheit', 'Kelvin'];
  var _fromCurrentSelectedItem = '';

  var _toUnits = ['Celsius', 'Fahrenheit', 'Kelvin'];
  var _toCurrentSelectedItem = '';

  bool _formulaVisibility = false;
  bool _genButtonVisibility = true;

  var _formulaWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fromCurrentSelectedItem = _fromUnits.elementAt(0);
    _toCurrentSelectedItem = _toUnits.elementAt(1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 40.0,
                      child: Text(
                        'From',
                        style: TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      ':',
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: EdgeInsets.only(left: 10.0, right: 5.0),
                      child: DropdownButton<String>(
                        selectedItemBuilder: (BuildContext context) {
                          return _fromUnits.map<Widget>((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    item,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  )
                                ],
                              ),
                            );
                          }).toList();
                        },
                        dropdownColor: Colors.black,
                        underline: Container(),
                        style: TextStyle(color: Colors.grey, fontSize: 15.0),
                        items: _fromUnits.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      item,
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                )
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String newSelectedItem) {
                          setState(() {
                            if (_fromCurrentSelectedItem != newSelectedItem) {
                              _genButtonVisibility = true;
                              _formulaVisibility = false;
                            }

                            if (newSelectedItem == _toCurrentSelectedItem) {
                              var temp = _fromCurrentSelectedItem;
                              _fromCurrentSelectedItem = newSelectedItem;
                              _toCurrentSelectedItem = temp;
                            } else {
                              _fromCurrentSelectedItem = newSelectedItem;
                            }
                          });
                        },
                        value: _fromCurrentSelectedItem,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 40.0,
                    child: Text(
                      'To',
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    ':',
                    style: TextStyle(color: Colors.grey, fontSize: 15.0),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.only(left: 10.0, right: 5.0),
                    child: DropdownButton<String>(
                      selectedItemBuilder: (BuildContext context) {
                        return _toUnits.map<Widget>((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  item,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15.0),
                                ),
                                SizedBox(
                                  width: 15.0,
                                )
                              ],
                            ),
                          );
                        }).toList();
                      },
                      dropdownColor: Colors.black,
                      underline: Container(),
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                      items: _toUnits.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    item,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 1.0,
                              )
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String newSelectedItem) {
                        setState(() {
                          if (_toCurrentSelectedItem != newSelectedItem) {
                            _genButtonVisibility = true;
                            _formulaVisibility = false;
                          }

                          if (newSelectedItem == _fromCurrentSelectedItem) {
                            var temp = _toCurrentSelectedItem;
                            _toCurrentSelectedItem = newSelectedItem;
                            _fromCurrentSelectedItem = temp;
                          } else {
                            _toCurrentSelectedItem = newSelectedItem;
                          }
                        });
                      },
                      value: _toCurrentSelectedItem,
                    ),
                  )
                ],
              ),
              Visibility(
                visible: _genButtonVisibility,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Container(
                    width: 215,
                    child: RaisedButton(
                      color: Colors.red[900],
                      elevation: 10,
                      child: Text(
                        "GENERATE",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _formulaVisibility = true;
                          _genButtonVisibility = false;

                          _generateFormulaWidget();
                        });
                      },
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Visibility(
                        visible: _formulaVisibility,
                        child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20.0, top: 25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black38,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15, right: 15),
                                child: Center(child: _formulaWidget),
                              ),
                            ))),
                  ),
                ],
              ),
            ]));
  }

  _generateFormulaWidget() {
    setState(() {
      if (_fromCurrentSelectedItem == _fromUnits.elementAt(0)) {
        if (_toCurrentSelectedItem == _toUnits.elementAt(1)) {
          _formulaWidget = RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "( ",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "Celsius value",
                  style: TextStyle(color: Colors.grey, fontSize: 18)),
              TextSpan(
                  text: " x ( 9/5 ) ) + 32 ",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
          );
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(2)) {
          _formulaWidget = RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Celsius value",
                  style: TextStyle(color: Colors.grey, fontSize: 18)),
              TextSpan(
                  text: " + 273.15 ",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
          );
        }
      } else if (_fromCurrentSelectedItem == _fromUnits.elementAt(1)) {
        if (_toCurrentSelectedItem == _toUnits.elementAt(0)) {
          _formulaWidget = RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "( ",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "Fahrenheit value",
                  style: TextStyle(color: Colors.grey, fontSize: 18)),
              TextSpan(
                  text: " − 32 ) × ( 5/9 )",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
          );
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(2)) {
          _formulaWidget = RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "( ( ",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "Fahrenheit value",
                  style: TextStyle(color: Colors.grey, fontSize: 18)),
              TextSpan(
                  text: " − 32 ) × ( 5/9 ) ) + 273.15",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
          );
        }
      } else if (_fromCurrentSelectedItem == _fromUnits.elementAt(2)) {
        if (_toCurrentSelectedItem == _toUnits.elementAt(0)) {
          _formulaWidget = RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Kelvin value",
                  style: TextStyle(color: Colors.grey, fontSize: 18)),
              TextSpan(
                  text: " - 273.15",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
          );
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(1)) {
          _formulaWidget = RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "( ( ",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "Kelvin value",
                  style: TextStyle(color: Colors.grey, fontSize: 18)),
              TextSpan(
                  text: " − 273.15 ) × ( 9/5 ) ) + 32",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
          );
        }
      }
    });
  }
}
