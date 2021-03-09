import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unitconverter/pressure_formulas_body.dart';
import 'package:unitconverter/temperature_formulas_body.dart';
import 'package:unitconverter/length_formulas_body.dart';
import 'package:unitconverter/mass_formulas_body.dart';
import 'package:unitconverter/volume_formulas_body.dart';
import 'package:intl/intl.dart';

class FormulasPage extends StatefulWidget {
  @override
  _FormulasPageState createState() => _FormulasPageState();
}

class _FormulasPageState extends State<FormulasPage> {
  int _selectedIndex = 0;

  List<Widget> _bodyList = <Widget>[FormulaPageBody(), UnitRelationsBody()];

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
              title: Text('Formulas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
              child: Container(
                decoration: ShapeDecoration(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red[900], width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    child: BottomNavigationBar(
                      unselectedItemColor: Colors.grey,
                      elevation: 10,
                      backgroundColor: Colors.grey[900],
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.dvr,
                            ),
                            title: Text('Formula Generator')),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.apps,
                            ),
                            title: Text('Unit Relationships'))
                      ],
                      currentIndex: _selectedIndex,
                      selectedItemColor: Colors.red,
                      onTap: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            body: _bodyList.elementAt(_selectedIndex)));
  }
}

class FormulaPageBody extends StatefulWidget {
  @override
  _FormulaPageBodyState createState() => _FormulaPageBodyState();
}

class _FormulaPageBodyState extends State<FormulaPageBody> {
  var _units = ['Temperature', 'Length', 'Mass', 'Volume', 'Pressure'];
  var _unitsCurrentSelectedItem = '';

  var _currentSelectedBody;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _unitsCurrentSelectedItem = _units.elementAt(0);
    _currentSelectedBody = TemperatureFormulasBody();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        //width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: EdgeInsets.only(left: 10.0, right: 5.0),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          iconSize: 30,
                          iconEnabledColor: Colors.white,
                          selectedItemBuilder: (BuildContext context) {
                            return _units.map<Widget>((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Center(
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 16.0),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList();
                          },
                          dropdownColor: Colors.black,
                          underline: Container(),
                          style: TextStyle(color: Colors.grey, fontSize: 15.0),
                          items: _units.map((String item) {
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
                              _unitsCurrentSelectedItem = newSelectedItem;
                              if (_unitsCurrentSelectedItem ==
                                  _units.elementAt(0)) {
                                _currentSelectedBody =
                                    TemperatureFormulasBody();
                              } else if (_unitsCurrentSelectedItem ==
                                  _units.elementAt(1)) {
                                _currentSelectedBody = LengthFormulasBody();
                              } else if (_unitsCurrentSelectedItem ==
                                  _units.elementAt(2)) {
                                _currentSelectedBody = MassFormulasBody();
                              } else if (_unitsCurrentSelectedItem ==
                                  _units.elementAt(3)) {
                                _currentSelectedBody = VolumeFormulasBody();
                              } else if (_unitsCurrentSelectedItem ==
                                  _units.elementAt(4)) {
                                _currentSelectedBody = PressureFormulasBody();
                              }
                            });
                          },
                          value: _unitsCurrentSelectedItem,
                        ),
                      ),
                    ),
                  ],
                ),
                _currentSelectedBody
              ]),
        ),
      ),
    );
  }
}

class UnitRelationsBody extends StatelessWidget {
  var numberFormatter = NumberFormat.decimalPattern();

  final _scrollController1 = ScrollController();
  final _scrollController2 = ScrollController();
  final _scrollController3 = ScrollController();
  final _scrollController4 = ScrollController();
  final _scrollController5 = ScrollController();
  final _scrollController6 = ScrollController();
  final _scrollController7 = ScrollController();



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Metric Prefixes',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1.5,
                                height: 1.5,
                              ),
                              Scrollbar(
                                isAlwaysShown: true,
                                controller: _scrollController1,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 15),
                                  child: SingleChildScrollView(
                                    controller: _scrollController1,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              'prefix',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'giga',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'mega',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'kilo',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'hecto',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'deka',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '---',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'deci',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'centi',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'milli',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'micro',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'nano',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              'symbol',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'G',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'M',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'k',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'h',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'da',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '---',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'd',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'c',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'm',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'µ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'n',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              'factor',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            EasyRichText(
                                              '109',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '9',
                                                  stringBeforeTarget: '10',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                )
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '106',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '6',
                                                  stringBeforeTarget: '10',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '103',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '3',
                                                  stringBeforeTarget: '10',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '102',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: '10',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '101',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '1',
                                                  stringBeforeTarget: '10',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '100',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '0',
                                                  stringBeforeTarget: '10',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '10-1',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '-1',
                                                  stringBeforeTarget: '10',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '10-2',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '-2',
                                                  stringBeforeTarget: '10',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '10-3',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '-3',
                                                  stringBeforeTarget: '10',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '10-6',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '-6',
                                                  stringBeforeTarget: '10',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '10-9',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '-9',
                                                  stringBeforeTarget: '10',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              'value',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  numberFormatter
                                                      .format(1000000000),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  numberFormatter
                                                      .format(1000000),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  numberFormatter.format(1000),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  numberFormatter.format(100),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  numberFormatter.format(10),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  numberFormatter.format(1),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '0.1',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '0.01',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '0.001',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '0.000001',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '0.000000001',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'SI Base Units',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1.5,
                                height: 1.5,
                              ),
                              Scrollbar(
                                isAlwaysShown: true,
                                controller: _scrollController2,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 15),
                                  child: SingleChildScrollView(
                                    controller: _scrollController2,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Base Quantity',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Length',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'Mass',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'Time',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'Electric current',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'Temperature',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'Amount of substance',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  'Luminous intensity',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Unit',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'metre',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'kilogram',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'second',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'ampere',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'kelvin',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'mole',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'candela',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              'Symbol',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'm',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'kg',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              's',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'A',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'K',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'mol',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'cd',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Units of Length in Metric System',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1.5,
                                height: 1.5,
                              ),
                              Scrollbar(
                                isAlwaysShown: true,
                                controller: _scrollController3,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 15),
                                  child: SingleChildScrollView(
                                    controller: _scrollController3,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '10 millimeters (mm)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 centimeters (cm)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 decimeters (dm)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 meters (m)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 dekameters (dam)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 hectometers (hm)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            EasyRichText(
                                              '1 centimeter (cm)',

                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 decimeter (dm)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 meter (m)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 dekameter (dam)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 hectometer (hm)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 kilometer (km)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  ' ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '100 millimeters (mm)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '1,000 millimeters (mm)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                 ' ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '100 meters (m)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '1,000 meters (m)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Units of Area in Metric System',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1.5,
                                height: 1.5,
                              ),
                              Scrollbar(
                                isAlwaysShown: true,
                                controller: _scrollController4,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 15),
                                  child: SingleChildScrollView(
                                    controller: _scrollController4,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            EasyRichText(
                                              '100 square millimeters (mm2)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'mm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '100 square centimeters (cm2)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'cm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '100 square decimeters (dm2)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'dm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '100 square meters (m2)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '100 square dekameters (dam2)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'dam',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '100 square hectometers (hm2)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'hm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            EasyRichText(
                                              '1 square centimeter (cm2)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'cm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 square decimeter (dm2)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'dm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 square meter (m2)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 square dekameter (dam2)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'dam',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 square hectometer (hm2) ',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'hm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 square kilometer (km2)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '2',
                                                  stringBeforeTarget: 'km',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  ' ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  ' ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  ' ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '1 are',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '1 hectare (ha)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  ' ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Units of Volume in Metric System',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1.5,
                                height: 1.5,
                              ),
                              Scrollbar(
                                isAlwaysShown: true,
                                controller: _scrollController5,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 15),
                                  child: SingleChildScrollView(
                                    controller: _scrollController5,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            EasyRichText(
                                              '1,000 cubic millimeters (mm3)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '3',
                                                  stringBeforeTarget: 'mm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1,000 cubic centimeters (cm3)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '3',
                                                  stringBeforeTarget: 'cm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1,000 cubic decimeters (dm3)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '3',
                                                  stringBeforeTarget: 'dm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            EasyRichText(
                                              '1 cubic centimeter (cm3)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '3',
                                                  stringBeforeTarget: 'cm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 cubic decimeter (dm3)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '3',
                                                  stringBeforeTarget: 'dm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 cubic meter (m3)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '3',
                                                  stringBeforeTarget: 'm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1,000,000 cubic millimeters (mm3)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '3',
                                                  stringBeforeTarget: 'mm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1,000,000 cubic centimeters (cm3)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '3',
                                                  stringBeforeTarget: 'cm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1,000,000,000 cubic millimeters (mm3)',
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: '3',
                                                  stringBeforeTarget: 'mm',
                                                  matchWordBoundaries: false,
                                                  superScript: true,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Units of Liquid Volume in\nMetric System',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1.5,
                                height: 1.5,
                              ),
                              Scrollbar(
                                isAlwaysShown: true,
                                controller: _scrollController6,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 15),
                                  child: SingleChildScrollView(
                                    controller: _scrollController6,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '10 milliliters (mL)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 centiliters (cL)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 deciliters (dL)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 liters (L)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 dekaliters (daL)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 hectoliters (hL)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            EasyRichText(
                                              '1 centiliter (cL)',

                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 deciliter (dL)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 liter (L)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 dekaliter (daL)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 hectoliter (hL)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 kiloliter (kL) ',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  ' ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '100 milliliters (mL)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '1,000 milliliters (mL)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  ' ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '100 liters (L)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '1,000 liters (L)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Units of Mass in Metric System',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1.5,
                                height: 1.5,
                              ),
                              Scrollbar(
                                isAlwaysShown: true,
                                controller: _scrollController7,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 15),
                                  child: SingleChildScrollView(
                                    controller: _scrollController7,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '10 milligrams (mg)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 centigrams (cg)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 decigrams (dg)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 grams (g)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 dekagrams (dag)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 hectograms (hg)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '1,000 kilograms (kg)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            EasyRichText(
                                              '1 centigram (cg)',

                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 decigram (dg)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 gram (g)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 dekagram (dag)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 hectogram (hg)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 kilogram (kg)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            EasyRichText(
                                              '1 metric ton (t)',
                                              defaultStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              ' ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  ' ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '100 milligrams (mg)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '1,000 milligrams (mg)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  ' ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '100 grams (g)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '1,000 grams (g)',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  ' ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ]),
                ])));
  }
}
