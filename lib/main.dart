// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MatchDay());

class MatchDay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyApp();
  }
}

class MyApp extends State<MatchDay> {
  var team = [0, 0];
  var team1 = 0;
  var team2 = 0;

  void updateNumbers(){
    setState(() {
      team1 = team[0];
      team2 = team[1];
    });
  }

  void resetPoints(){
    team[0]=0;
    team[1]=0;
    updateNumbers();
  }

  void subtractNumbers(int teamIndex) {
    if(overzero(team[teamIndex])){
      team[teamIndex] --;
      updateNumbers();
    }
  }

  void addNumbers(int teamIndex) {
    if(underNinetyNine(team[teamIndex])){
      team[teamIndex] ++;
      updateNumbers();
    }
  }

  bool underNinetyNine(var team) {
    if(team<99){
      return true;
    }
    else{
      return false;
    }
  }

  bool overzero(var team) {
    if(team >0){
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spielstandsapp',
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Spielstandsapp'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: new RaisedButton(
                        color: Colors.grey[800],
                        padding: const EdgeInsets.all(10.10),
                        disabledColor: Colors.green,
                        onPressed: resetPoints,
                        textColor: Colors.black,
                        disabledTextColor: Colors.black,
                        child: Text("Reset"),
                      )
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: new Text("$team1:$team2",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 120.0,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: new RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 24.0),
                        color: Colors.green,
                        disabledColor: Colors.green,
                        onPressed: () => addNumbers(0),
                        textColor: Colors.black,
                        disabledTextColor: Colors.black,
                        child: Text("Team 1"),
                      )
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                      child: new RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 24.0),
                        color: Colors.green,
                        disabledColor: Colors.green,
                        onPressed: () => addNumbers(1),
                        textColor: Colors.black,
                        disabledTextColor: Colors.black,
                        child: Text("Team 2"),
                      )
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 10,
                  ),
                ],
              ),
              Row(
                children: <Widget>[

                  Expanded(
                      child: new RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 24.0),
                        onPressed: () => subtractNumbers(0),
                        color: Colors.red[900],
                        disabledColor: Colors.red[900],
                        textColor: Colors.black,
                        disabledTextColor: Colors.black,
                        child: Text("Team 1"),
                      )
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                      child: new RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 24.0),
                        onPressed: () => subtractNumbers(1),
                        color: Colors.red[900],
                        disabledColor: Colors.red[900],
                        textColor: Colors.black,
                        disabledTextColor: Colors.black,
                        child: Text("Team 2"),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}