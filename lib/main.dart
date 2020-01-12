// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard_app/States.dart';
import 'package:firebase_database/firebase_database.dart';

import 'Scoreboard.dart';

void main() => runApp(MatchDay());

class MatchDay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MyApp();
  }
}

class MyApp extends State<MatchDay> {
  final databaseReference = FirebaseDatabase.instance.reference();
  var team1 = 0;
  var team2 = 0;
  var name1 = "TEAM 1";
  var name2 = "TEAM 2";
  var gameRunning = States.stateMessage(States.Start);
  Scoreboard scoreboard = new Scoreboard();
  int idOfGames;

  void updateNumbers() {
    setState(() {
      team1 = scoreboard.team[0];
      team2 = scoreboard.team[1];
    });
  }

  void choiceAction(String choice) {
    setState(() {
      gameRunning = States.stateMessage(choice);
      if(gameRunning == States.stateMessage(States.NewMatch)){
        newGameInDatabase();
      }
      else{
        updateEntryInDatabase(team1, team2);
      }
    });
  }

  void setGame(String choic) {}

  @override
  Widget build(BuildContext context) {
    getIDFromDatabase();
    return MaterialApp(
      title: 'Spielstandsapp',
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return States.GameStates.map((String state) {
                  return PopupMenuItem<String>(
                    value: state,
                    child: Text(state),
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
                    child: new TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'What do people call you?',
                        labelText: 'Name *',
                      ),
                      onFieldSubmitted: (String value) {
                        updateEntryInDatabaseName1(value);
                        updateNumbers();
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                    ),
                  ),
                  Expanded(
                    child: new TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'What do people call you?',
                        labelText: 'Name *',
                      ),
                      onFieldSubmitted: (String value) {
                        updateEntryInDatabaseName2(value);
                        updateNumbers();
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                    ),
                  )
                ],
              ),
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
                      updateEntryInDatabase(team1, team2);
                    },
                    textColor: Colors.black,
                    disabledTextColor: Colors.black,
                    child: Text("Reset state: " + '$gameRunning'),
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: new Text(
                      "$team1:$team2",
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
                    padding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 24.0),
                    color: Colors.green,
                    disabledColor: Colors.green,
                    onPressed: () {
                      scoreboard.addNumbers(0);
                      updateNumbers();
                      updateEntryInDatabase(team1, team2);
                    },
                    textColor: Colors.black,
                    disabledTextColor: Colors.black,
                    child: Text(name1),
                  )),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                      child: new RaisedButton(
                    padding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 24.0),
                    color: Colors.green,
                    disabledColor: Colors.green,
                    onPressed: () {
                      scoreboard.addNumbers(1);
                      updateNumbers();
                      updateEntryInDatabase(team1, team2);
                    },
                    textColor: Colors.black,
                    disabledTextColor: Colors.black,
                    child: Text(name2),
                  )),
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
                    padding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 24.0),
                    onPressed: () {
                      scoreboard.subtractNumbers(0);
                      updateNumbers();
                      updateEntryInDatabase(team1, team2);
                    },
                    color: Colors.red[900],
                    disabledColor: Colors.red[900],
                    textColor: Colors.black,
                    disabledTextColor: Colors.black,
                    child: Text(name1),
                  )),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                      child: new RaisedButton(
                    padding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 24.0),
                    onPressed: () {
                      scoreboard.subtractNumbers(1);
                      updateNumbers();
                      updateEntryInDatabase(team1, team2);
                    },
                    color: Colors.red[900],
                    disabledColor: Colors.red[900],
                    textColor: Colors.black,
                    disabledTextColor: Colors.black,
                    child: Text(name2),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateEntryInDatabase(int team1, int team2) {
    databaseReference.child(idOfGames.toString()).set({
      'name1': name1,
      'name2': name2,
      'score1': "$team1",
      'score2': "$team2",
      'state': gameRunning
    });
  }

  void updateEntryInDatabaseName1(String teamname) {
    name1 = teamname;
    databaseReference.child(idOfGames.toString()).set({
      'name1': name1,
      'name2': name2,
      'score1': "$team1",
      'score2': "$team2",
      'state': gameRunning
    });
  }

  void updateEntryInDatabaseName2(String teamname) {
    name2 = teamname;
    databaseReference.child(idOfGames.toString()).set({
      'name1': name1,
      'name2': name2,
      'score1': "$team1",
      'score2': "$team2",
      'state': gameRunning
    });
  }

  void getIDFromDatabase() {
    var db = FirebaseDatabase.instance.reference().child("id");
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      idOfGames = values["id"];
    });
  }

  void increaseID(){
    idOfGames = idOfGames + 1;
  }

  void newGameInDatabase() {
    increaseID();
    databaseReference.child("id").set({
      'id': idOfGames
    });
    updateEntryInDatabase(team1, team2);
  }
}
