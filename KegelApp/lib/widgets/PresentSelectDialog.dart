import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/screens/new_session_screen.dart';
import 'package:flutter/material.dart';

class PresentDialog extends StatefulWidget {
  @override
  _PresentDialogState createState() => _PresentDialogState();
}

class _PresentDialogState extends State<PresentDialog> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FutureBuilder(
        future: DBProvider.db.getAllKegelbruder(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Noch keine Spieler hinzugefügt!"),
            );
          }
          if (snapshot.hasData) {
            List<Kegelbruder> kegelbruderListe = snapshot.data;
            return Container(
              height: 400,
              width: 400,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.49,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 120,
                                child: Text(kegelbruderListe[index].name),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      icon: kegelbruderListe[index].anwesend ==
                                              0
                                          ? Icon(Icons.check_box_outline_blank)
                                          : Icon(Icons.check_box),
                                      onPressed: () {
                                        setState(() {
                                          changeAnwesend(
                                              kegelbruderListe[index].name);
                                        });
                                      }),
                                  Text(
                                    "Anwesend",
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: kegelbruderListe[index].abwesend == 0
                                        ? Icon(Icons.check_box_outline_blank)
                                        : Icon(Icons.check_box),
                                    onPressed: () {
                                      setState(() {
                                        changeAbwesend(
                                            kegelbruderListe[index].name);
                                      });
                                    },
                                  ),
                                  Text(
                                    "Abwesend",
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: kegelbruderListe[index]
                                                .unabgemeldet ==
                                            0
                                        ? Icon(Icons.check_box_outline_blank)
                                        : Icon(Icons.check_box),
                                    onPressed: () {
                                      setState(() {
                                        changeUnabgemeldet(
                                            kegelbruderListe[index].name);
                                      });
                                    },
                                  ),
                                  Text(
                                    "Unabgemeldet",
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: kegelbruderListe.length,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(NewSessionScreen.routeName);
                          },
                          child: Text("Kegelabend starten")),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Abbrechen"))
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
