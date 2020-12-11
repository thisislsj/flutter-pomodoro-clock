import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Pomodoro(),
  ));
}

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  double percent = 0;
  static int timeInMinute = 25;
  int timeInSec = timeInMinute * 60;
  //import dart async library and add a timer object
  Timer timer;

  _startTimer() {
    timeInMinute = 25;
    int time = timeInMinute * 60;
    double secPercent = (time / 100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) {
          time--;
          if (time % 60 == 0) {
            timeInMinute--;
          }
          if (time % secPercent == 0) {
            if (percent < 1) {
              percent += 0.01;
            } else {
              percent = 1;
            }
          }
        } else {
          percent = 0;
          timeInMinute = 25;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.orange, Colors.red],
              begin: FractionalOffset(0.1, 0.7)),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text("Pomodoro Clock",
                  style: TextStyle(color: Colors.white, fontSize: 40.0)),
            ),
            Expanded(
              child: CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.round,
                radius: 250,
                percent: percent,
                animation: true,
                animateFromLastPercent: true,
                lineWidth: 20.0,
                progressColor: Colors.white,
                center: Text(
                  "$timeInMinute",
                  style: TextStyle(color: Colors.white, fontSize: 80),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                  child: Column(children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Study Time",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "25",
                                  style: TextStyle(fontSize: 80.0),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Pause Time",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "5",
                                  style: TextStyle(fontSize: 80.0),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 28.0),
                      child: RaisedButton(
                        onPressed: _startTimer,
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "Start Studying",
                            style:
                                TextStyle(color: Colors.white, fontSize: 22.0),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
