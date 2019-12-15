// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:scoreboard_app/Constants.dart';

import 'Scoreboard.dart';

void main() => runApp(MatchDay());

class MatchDay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyApp();
  }
}



class MyApp extends State<MatchDay> {
  var team1 = 0;
  var team2 = 0;
  var gameRunning = "stopped";
  Scoreboard scoreboard = new Scoreboard();

  void updateNumbers(){
    setState(() {
      team1 = scoreboard.team[0];
      team2 = scoreboard.team[1];
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void choiceAction(String choice){
    if(choice == Constants.Start){
      gameRunning = "running";
    }
    else if(choice == Constants.Stop){
      _showDialog();
      gameRunning = "stopped";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spielstandsapp',
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return Constants.Choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            )
          ],
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
                        onPressed: () {
                          scoreboard.resetPoints();
                          updateNumbers();
                        },
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
                        onPressed: () {
                          scoreboard.addNumbers(0);
                          updateNumbers();
                        },
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
                        onPressed: () {
                          scoreboard.addNumbers(1);
                          updateNumbers();
                        },
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
                        onPressed: () {
                          scoreboard.subtractNumbers(0);
                          updateNumbers();
                        },
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
                        onPressed: () {
                          scoreboard.subtractNumbers(1);
                          updateNumbers();
                        },
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