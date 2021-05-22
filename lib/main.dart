import 'package:alert/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String target = "";
  String quantity = "";
  String profit_per_share = "";
  String total_profit = "";

  TextEditingController _entryEditingController = new TextEditingController();
  TextEditingController _stopLossEditingController =
      new TextEditingController();
  TextEditingController _riskEditingController = new TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'The Intelligent Trader',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.blue[800],
                    margin: EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: (const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 25.0)),
                          child: Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "The Inteligent Trader",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontFamily: 'Gilroy',
                                      shadows: [
                                        Shadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            offset: Offset(5, 5),
                                            blurRadius: 15),
                                      ]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 0.0),
                                  padding: EdgeInsets.only(right: 0.0),
                                  child: Text(
                                    "Trade like a pro",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.white),
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _entryEditingController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          style: TextStyle(fontFamily: 'Gilroy-Light'),
                          decoration: InputDecoration(
                            labelText: "Entry",
                            fillColor: Colors.grey,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue[800]),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: _stopLossEditingController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          style: TextStyle(fontFamily: 'Gilroy-Light'),
                          decoration: InputDecoration(
                            labelText: "Stop Loss",
                            fillColor: Colors.grey,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue[800]),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: _riskEditingController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [ThousandsFormatter()],
                          style: TextStyle(fontFamily: 'Gilroy-Light'),
                          decoration: InputDecoration(
                            labelText: "Risk",
                            fillColor: Colors.grey,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue[800]),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[800], // background
                                  onPrimary: Colors.blue[300], // foreground
                                ),
                                onPressed: () {
                                  setState(() {
                                    String entryString =
                                        _entryEditingController.text.toString();
                                    entryString = entryString.replaceAll(
                                        new RegExp(r','), '');

                                    String stopLossString =
                                        _stopLossEditingController.text
                                            .toString();

                                    stopLossString = stopLossString.replaceAll(
                                        new RegExp(r','), '');

                                    String riskString =
                                        _riskEditingController.text.toString();

                                    riskString = riskString.replaceAll(
                                        new RegExp(r','), '');

                                    // print(ent);
                                    // print(risk);
                                    // print(stopLoss);

                                    //
                                    if (entryString == "" ||
                                        stopLossString == "" ||
                                        riskString == "") {
                                      Alert(message: 'Invalid inputs').show();
                                    } else {
                                      var risk = int.parse(riskString);
                                      var stopLoss =
                                          double.parse(stopLossString);

                                      var ent = double.parse(entryString);

                                      if (stopLoss > ent) {
                                        Alert(
                                            message:
                                                'Stop Loss must be greater than Entry').show();
                                      } else {
                                        var pps = (ent - stopLoss) * 2;
                                        var qty = risk / (ent - stopLoss);
                                        var trgt = ent + pps;
                                        var ttlprft = pps * qty.toInt();

                                        target = double.parse(trgt.toStringAsFixed(2)).toString();
                                        quantity = qty.toInt().toString();
                                        profit_per_share =
                                            double.parse(pps.toStringAsFixed(2)).toString();
                                        total_profit =
                                            double.parse(ttlprft.toStringAsFixed(2)).toString();
                                      }
                                    }
                                  });
                                },
                                child: Text(
                                  'Calculate',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[800], // background
                                  onPrimary: Colors.blue[300], // foreground
                                ),
                                onPressed: () {
                                  setState(() {
                                    _entryEditingController.clear();
                                    _stopLossEditingController.clear();
                                    _riskEditingController.clear();

                                    target = "";
                                    quantity = "";
                                    profit_per_share = "";
                                    total_profit = "";
                                  });
                                },
                                child: Text(
                                  'Reset',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy'),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Card(
                          child: ListTile(
                            leading: Text(
                              'Target: ' + target,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Gilroy-Light',
                                  color: Colors.grey),
                            ),
                            title: Text(
                              target,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Gilroy-Light',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Card(
                          child: ListTile(
                            leading: Text(
                              'Quantity: ' + quantity,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Gilroy-Light',
                                  color: Colors.grey),
                            ),
                            title: Text(
                              quantity,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Gilroy-Light',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Card(
                          child: ListTile(
                            leading: Text(
                              'Profit per share: ' + profit_per_share,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Gilroy-Light',
                                  color: Colors.grey),
                            ),
                            title: Text(
                              '50',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Gilroy-Light',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Card(
                          color: Colors.green[800],
                          child: ListTile(
                            leading: Text(
                              'Total profit: ' + total_profit,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Gilroy',
                                  color: Colors.white),
                            ),
                            // title: Text(
                            //   total_profit,
                            //   style: TextStyle(
                            //       fontSize: 20,
                            //       fontFamily: 'Gilroy-Light',
                            //       color: Colors.white),
                            // ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
