import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class MassConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).popUntil(
                          (route) => route.settings.name == '/homepage');
                    },
                  ),
                )
              ],
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  //side: BorderSide(color: Colors.red[900], width: 2.0),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              centerTitle: true,
              backgroundColor: Colors.red[900],
              title: Text('Mass\nConverter',
                  textScaleFactor: 0.8,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            body: IconSet()));
  }
}

class IconSet extends StatefulWidget {
  @override
  _IconSetState createState() => _IconSetState();
}

class _IconSetState extends State<IconSet> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController amountController = TextEditingController();

  var _fromUnits = [
    'Tonne',
    'Kilogram',
    'Gram',
    'Milligram',
    'Microgram',
    'Pound',
    'Ounce'
  ];
  var _fromCurrentSelectedItem = '';

  var _toUnits = [
    'Tonne',
    'Kilogram',
    'Gram',
    'Milligram',
    'Microgram',
    'Pound',
    'Ounce'
  ];
  var _toCurrentSelectedItem = '';

  var amount = '';

  TextEditingController answerController = TextEditingController();
  double answer;

  var answerFormatter = NumberFormat.decimalPattern();
  var amountFormatter = NumberFormat.decimalPattern();
  bool answerVisibility = false;

  TextStyle textStyle = TextStyle(color: Colors.grey, fontSize: 15.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fromCurrentSelectedItem = _fromUnits.elementAt(0);
    _toCurrentSelectedItem = _toUnits.elementAt(1);
    answerFormatter.maximumFractionDigits = 3;
    answerFormatter.minimumFractionDigits = 0;
    amountFormatter.maximumFractionDigits = 5;
    amountFormatter.minimumFractionDigits = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
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
                              if (newSelectedItem == _toCurrentSelectedItem) {
                                var temp = _fromCurrentSelectedItem;
                                _fromCurrentSelectedItem = newSelectedItem;
                                _toCurrentSelectedItem = temp;
                              } else {
                                _fromCurrentSelectedItem = newSelectedItem;
                              }

                              answerVisibility = false;
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
                            if (newSelectedItem == _fromCurrentSelectedItem) {
                              var temp = _toCurrentSelectedItem;
                              _toCurrentSelectedItem = newSelectedItem;
                              _fromCurrentSelectedItem = temp;
                            } else {
                              _toCurrentSelectedItem = newSelectedItem;
                            }

                            answerVisibility = false;
                          });
                        },
                        value: _toCurrentSelectedItem,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      hintText: 'Enter the amount',
                      labelStyle: textStyle,
                      hintStyle: textStyle,
                      errorStyle: TextStyle(color: Colors.red, fontSize: 15.0),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.red, width: 1.5)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.5)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.5)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.5)),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter the amount";
                      }

                      if ((double.tryParse(value.replaceAll(",", "")) ==
                              null) &&
                          value.isNotEmpty) {
                        return "Amount must be a number";
                      }

                      return null;
                    },
                    controller: amountController,
                    inputFormatters: [
                      ThousandsFormatter(
                          allowFraction: true, formatter: amountFormatter),
                    ],
                    minLines: 1,
                    maxLines: 2,
                    onChanged: (String value) {
                      setState(() {
                        answerVisibility = false;
                      });
                    },
                    cursorColor: Colors.red,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Visibility(
                  visible: answerVisibility,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      maxLines: 3,
                      minLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Answer',
                        labelStyle: textStyle,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5)),
                      ),

                      controller: answerController,
                      style: TextStyle(color: Colors.red, fontSize: 20.0),
                      // initialValue: answer,
                      readOnly: true,
                      showCursor: false,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        splashColor: Colors.transparent,
                        elevation: 10.0,
                        child: Text(
                          'RESET',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            amountController.text = '';
                            answerController.text = '';
                            answerVisibility = false;
                            _fromCurrentSelectedItem = _fromUnits.elementAt(0);
                            _toCurrentSelectedItem = _toUnits.elementAt(1);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: RaisedButton(
                        color: Colors.red[900],
                        textColor: Colors.white,
                        splashColor: Colors.redAccent[700],
                        elevation: 10.0,
                        child: Text('CALCULATE',
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              amount =
                                  amountController.text.replaceAll(",", "");
                              _calculate();
                              answerVisibility = true;
                            });
                          } else {
                            setState(() {
                              answerVisibility = false;
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  /* var _fromUnits = [
    'Tonne',
    'Kilogram',
    'Gram',
    'Milligram',
    'Microgram',
    'Pound',
    'Ounce'
  ];*/
  //method to calculate
  _calculate() {
    double amountValue = double.tryParse(amount);
    setState(() {
      if (_fromCurrentSelectedItem == _fromUnits.elementAt(0)) {
        if (_toCurrentSelectedItem == _toUnits.elementAt(1)) {
          answer = amountValue * 1000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(2)) {
          answer = amountValue * 1000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(3)) {
          answer = amountValue * 1000000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(4)) {
          answer = amountValue * 1000000000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(5)) {
          answer = amountValue * 2205;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(6)) {
          answer = amountValue * 35274;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        }
      } else if (_fromCurrentSelectedItem == _fromUnits.elementAt(1)) {
        if (_toCurrentSelectedItem == _toUnits.elementAt(0)) {
          answer = amountValue / 1000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(2)) {
          answer = amountValue * 1000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(3)) {
          answer = amountValue * 1000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(4)) {
          answer = amountValue * 1000000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(5)) {
          answer = amountValue * 2.205;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(6)) {
          answer = amountValue * 35.274;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        }
      } else if (_fromCurrentSelectedItem == _fromUnits.elementAt(2)) {
        if (_toCurrentSelectedItem == _toUnits.elementAt(0)) {
          answer = amountValue / 1000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(1)) {
          answer = amountValue / 1000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(3)) {
          answer = amountValue * 1000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(4)) {
          answer = amountValue * 1000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(5)) {
          answer = amountValue / 454;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(6)) {
          answer = amountValue / 28.35;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        }
      } else if (_fromCurrentSelectedItem == _fromUnits.elementAt(3)) {
        if (_toCurrentSelectedItem == _toUnits.elementAt(0)) {
          answer = amountValue / 1000000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(1)) {
          answer = amountValue / 1000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(2)) {
          answer = amountValue / 1000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(4)) {
          answer = amountValue * 1000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(5)) {
          answer = amountValue / 453592;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(6)) {
          answer = amountValue / 28350;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        }
      } else if (_fromCurrentSelectedItem == _fromUnits.elementAt(4)) {
        if (_toCurrentSelectedItem == _toUnits.elementAt(0)) {
          answer = amountValue / 1000000000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(1)) {
          answer = amountValue / 1000000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(2)) {
          answer = amountValue / 1000000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(3)) {
          answer = amountValue / 1000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(5)) {
          answer = amountValue / 453600000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(6)) {
          answer = amountValue / 28350000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        }
      } else if (_fromCurrentSelectedItem == _fromUnits.elementAt(5)) {
        if (_toCurrentSelectedItem == _toUnits.elementAt(0)) {
          answer = amountValue / 2205;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(1)) {
          answer = amountValue / 2.205;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(2)) {
          answer = amountValue * 454;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(3)) {
          answer = amountValue * 453592;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(4)) {
          answer = amountValue * 453600000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(6)) {
          answer = amountValue * 16;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        }
      } else if (_fromCurrentSelectedItem == _fromUnits.elementAt(6)) {
        if (_toCurrentSelectedItem == _toUnits.elementAt(0)) {
          answer = amountValue / 35274;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(1)) {
          answer = amountValue / 35.274;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(2)) {
          answer = amountValue * 28.35;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(3)) {
          answer = amountValue * 28350;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(4)) {
          answer = amountValue * 28350000;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        } else if (_toCurrentSelectedItem == _toUnits.elementAt(5)) {
          answer = amountValue / 16;
          if (answer.toInt() != answer) {
            answerController.text = answerFormatter.format(answer);
          } else {
            answerController.text = answerFormatter.format(answer.toInt());
          }
        }
      }
    });
  }
}
