import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:flutter/material.dart';

class KingSelectDialog extends StatefulWidget {
  @override
  _KingSelectDialogState createState() => _KingSelectDialogState();
}

class _KingSelectDialogState extends State<KingSelectDialog> {
  KegelColor color = new KegelColor();
  int buttonPress = 1;
  bool isChecked = false;

  void changeKing(String name) async {
    List<Kegelbruder> allPlayer = await DBProvider.db.getAllKegelbruder();

    allPlayer.forEach((player) async {
      if (player.name == name) {
        player.setIsKing(1);
        await DBProvider.db.updateKegelbruder(player);
        print(player.name + " " + player.isKing.toString());
        if (player.isKing > 1) {
          player.isKing = 0;
          await DBProvider.db.updateKegelbruder(player);
          print(player.name + " " + player.isKing.toString());
        }
      } else if (player.name != name) {
        player.isKing = 0;
        await DBProvider.db.updateKegelbruder(player);
      }
    });
  }

  void changePumpenKing(String name) async {
    List<Kegelbruder> allPlayer = await DBProvider.db.getAllKegelbruder();

    allPlayer.forEach((player) async {
      if (player.name == name) {
        player.setIsPumpenKing(1);
        await DBProvider.db.updateKegelbruder(player);
        if (player.isPumpenKing > 1) {
          player.isPumpenKing = 0;
          await DBProvider.db.updateKegelbruder(player);
        }
      } else if (player.name != name) {
        player.isPumpenKing = 0;
        await DBProvider.db.updateKegelbruder(player);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 500,
        width: 350,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    setState(() {
                      buttonPress = 1;
                    });
                  },
                  child: Text(
                    "Kegelk??nig",
                    style: TextStyle(fontSize: 18),
                  ),
                  color: buttonPress == 1 ? color.blueContainer : Colors.white,
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      buttonPress = 2;
                    });
                  },
                  child: Text(
                    "Pumpenk??nig",
                    style: TextStyle(fontSize: 18),
                  ),
                  color: buttonPress == 2 ? color.blueContainer : Colors.white,
                )
              ],
            ),
            buttonPress == 1
                ? FutureBuilder(
                    future: DBProvider.db.getAllKegelbruder(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Keine Spieler verf??gber"),
                        );
                      }
                      if (snapshot.hasData) {
                        List<Kegelbruder> kegelbruderListe = snapshot.data;
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.59,
                          child: ListView.builder(
                            itemCount: kegelbruderListe.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  kegelbruderListe[index].name,
                                  style: TextStyle(fontSize: 17),
                                ),
                                trailing: kegelbruderListe[index].isKing == 1
                                    ? Icon(Icons.check_box)
                                    : Icon(Icons.check_box_outline_blank),
                                onTap: () {
                                  setState(() {
                                    changeKing(kegelbruderListe[index].name);
                                  });
                                },
                              );
                            },
                          ),
                        );
                      }
                    },
                  )
                : FutureBuilder(
                    future: DBProvider.db.getAllKegelbruder(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Keine Spieler verf??gber"),
                        );
                      }
                      if (snapshot.hasData) {
                        List<Kegelbruder> kegelbruderListeZwei = snapshot.data;
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.59,
                          child: ListView.builder(
                            itemCount: kegelbruderListeZwei.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  kegelbruderListeZwei[index].name,
                                  style: TextStyle(fontSize: 17),
                                ),
                                trailing:
                                    kegelbruderListeZwei[index].isPumpenKing ==
                                            1
                                        ? Icon(Icons.check_box)
                                        : Icon(Icons.check_box_outline_blank),
                                onTap: () {
                                  setState(() {
                                    changePumpenKing(
                                        kegelbruderListeZwei[index].name);
                                  });
                                },
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Okay")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Abbrechen"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
