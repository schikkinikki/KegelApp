// ignore_for_file: deprecated_member_use, missing_return

import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:KegelApp/main.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/screens/new_session_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PresentSelectScreen extends StatefulWidget {
  static const routeName = "/present-select-screen";

  @override
  _PresentSelectScreenState createState() => _PresentSelectScreenState();
}

class _PresentSelectScreenState extends State<PresentSelectScreen> {
  KegelColor color = new KegelColor();
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();

  List<int> anwesendCheck = [];
  List<int> abwesendCheck = [];
  List<int> unabgemeldetCheck = [];

  void setSessionActive() async {
    SharedPreferences preferences = await sharedPrefs;
    preferences.setBool(KegelApp.sessionActiveKey, true);
  }

  void fillAnwesendCheck(List<Kegelbruder> kegelbruderListe) {
    kegelbruderListe.forEach((element) {
      anwesendCheck.add(0);
    });
  }

  void fillAbwesendCheck(List<Kegelbruder> kegelbruderListe) {
    kegelbruderListe.forEach((element) {
      abwesendCheck.add(0);
    });
  }

  void fillUnabgemeldetCheck(List<Kegelbruder> kegelbruderListe) {
    kegelbruderListe.forEach((element) {
      unabgemeldetCheck.add(0);
    });
  }

  void changeAnwesendCheck(int index) {
    if (anwesendCheck[index] != 1) {
      anwesendCheck.removeAt(index);
      anwesendCheck.insert(index, 1);
    } else {
      anwesendCheck.removeAt(index);
      anwesendCheck.insert(index, 0);
    }
  }

  void changeAbwesendCheck(int index) {
    if (abwesendCheck[index] != 1) {
      abwesendCheck.removeAt(index);
      abwesendCheck.insert(index, 1);
    } else {
      abwesendCheck.removeAt(index);
      abwesendCheck.insert(index, 0);
    }
  }

  void changeUnabgemeldetCheck(int index) {
    if (unabgemeldetCheck[index] != 1) {
      unabgemeldetCheck.removeAt(index);
      unabgemeldetCheck.insert(index, 1);
    } else {
      unabgemeldetCheck.removeAt(index);
      unabgemeldetCheck.insert(index, 0);
    }
  }

  void changeAnwesend(String name) async {
    List<Kegelbruder> allPlayer = await DBProvider.db.getAllKegelbruder();

    allPlayer.forEach((player) async {
      if (player.name == name) {
        player.setAnwesend(1);
        await DBProvider.db.updateKegelbruder(player);

        if (player.anwesend > 1) {
          player.anwesend = 0;
          await DBProvider.db.updateKegelbruder(player);
        }
      }
    });
  }

  void changeAbwesend(String name) async {
    List<Kegelbruder> allPlayer = await DBProvider.db.getAllKegelbruder();

    allPlayer.forEach((player) async {
      if (player.name == name) {
        player.setAbwesend(1);
        await DBProvider.db.updateKegelbruder(player);

        if (player.abwesend > 1) {
          player.abwesend = 0;
          await DBProvider.db.updateKegelbruder(player);
        }
      }
    });
  }

  void changeUnabgemeldet(String name) async {
    List<Kegelbruder> allPlayer = await DBProvider.db.getAllKegelbruder();

    setState(() {
      allPlayer.forEach((player) async {
        if (player.name == name) {
          player.setUnabgemeldet(1);
          await DBProvider.db.updateKegelbruder(player);

          if (player.unabgemeldet > 1) {
            player.unabgemeldet = 0;
            await DBProvider.db.updateKegelbruder(player);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.darkBackground,
      appBar: AppBar(
        title: Text(
          "Anwesenheit",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: color.greyText,
          ),
        ),
        backgroundColor: color.darkBackground,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: color.darkBackground,
            height: MediaQuery.of(context).size.height * 0.75,
            child: FutureBuilder(
              future: DBProvider.db.getAllKegelbruder(),
              builder: (context, snapshot) {
                List<Kegelbruder> kegelbruderListe = snapshot.data;
                if (!snapshot.hasData) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sentiment_dissatisfied,
                        color: color.greyText,
                        size: 40,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Noch keine Mitglieder hinzugefügt.",
                        style: TextStyle(color: color.greyText, fontSize: 18),
                      )
                    ],
                  ));
                }
                if (snapshot.hasData) {
                  fillAnwesendCheck(kegelbruderListe);
                  fillAbwesendCheck(kegelbruderListe);
                  fillUnabgemeldetCheck(kegelbruderListe);
                  return ListView.builder(
                    itemCount: kegelbruderListe.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(7),
                        padding: EdgeInsets.only(left: 5, right: 5),
                        height: 60,
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                kegelbruderListe[index].name,
                                style: TextStyle(color: color.greyText),
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: anwesendCheck[index] == 0
                                        ? Icon(
                                            Icons.check_box_outline_blank,
                                            color: color.greyText,
                                          )
                                        : Icon(
                                            Icons.check_box,
                                            color: color.greyText,
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        changeAnwesendCheck(index);
                                        changeAnwesend(
                                            kegelbruderListe[index].name);
                                      });
                                    }),
                                Text(
                                  "Anwesend",
                                  style: TextStyle(
                                      fontSize: 10, color: color.greyText),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: abwesendCheck[index] == 0
                                        ? Icon(Icons.check_box_outline_blank,
                                            color: color.greyText)
                                        : Icon(
                                            Icons.check_box,
                                            color: color.greyText,
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        changeAbwesendCheck(index);
                                        changeAbwesend(
                                            kegelbruderListe[index].name);
                                      });
                                    }),
                                Text(
                                  "Abwesend",
                                  style: TextStyle(
                                      fontSize: 10, color: color.greyText),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: unabgemeldetCheck[index] == 0
                                        ? Icon(Icons.check_box_outline_blank,
                                            color: color.greyText)
                                        : Icon(Icons.check_box,
                                            color: color.greyText),
                                    onPressed: () {
                                      setState(() {
                                        changeUnabgemeldetCheck(index);
                                        changeUnabgemeldet(
                                            kegelbruderListe[index].name);
                                      });
                                    }),
                                Text(
                                  "Unabgemeldet",
                                  style: TextStyle(
                                      fontSize: 10, color: color.greyText),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                  onPressed: () {
                    setSessionActive();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(NewSessionScreen.routeName);
                  },
                  child: Text(
                    "Kegelabend starten",
                    style: TextStyle(color: color.greyText),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Abbrechen",
                    style: TextStyle(color: color.greyText),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
