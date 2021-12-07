import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:KegelApp/kegelapp_res/kegel_strings.dart';
import 'package:KegelApp/models/MembersListClass.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/models/session.dart';
import 'package:KegelApp/screens/sessions_screen.dart';
import 'package:KegelApp/widgets/KingSelectDialog.dart';
import 'package:KegelApp/widgets/NewDropDownMenu.dart';
import 'package:KegelApp/widgets/SessionOverviewDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewSessionScreen extends StatefulWidget {
  static const routeName = "/new-session-screen";

  @override
  _NewSessionScreenState createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends State<NewSessionScreen> {
  @override
  Widget build(BuildContext context) {
    KegelColor color = new KegelColor();
    KegelStrings strings = new KegelStrings();
    final memberData = Provider.of<MemberListClass>(context);
    final List<String> strafenUiListe = [
      "Pumpe",
      "Klingeln",
      "3 mittig",
      "Durchwurf",
      "Handy",
      "Kugel bringen",
      "Zu 2. auf der Bahn",
      "Lustwurf",
      "Kugel zum Klo",
      "Kugel fallenlassen",
      "Alle Neune"
    ];

    void saveAndResetSession() async {
      var date = DateFormat("dd-MM-yyyy");
      var dateString = date.format(DateTime.now());

      List<Kegelbruder> list = await DBProvider.db.getAllKegelbruder();
      list.forEach((member) async {
        var session = new Session(date: dateString, kegelbruder: member);
        await DBProvider.db.addSession(session);
      });
    }

    void showCustomAlertDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(strings.newsessionscreen_save_exit),
            content: Text(strings.newsessionscreen_dialog_save),
            actions: [
              FlatButton(
                onPressed: () {
                  saveAndResetSession();
                  memberData.startNewSession();
                  Navigator.of(context).pop();
                },
                child: const Text("Okay"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Nein"),
              ),
            ],
          );
        },
      );
    }

    void showResetAlertDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(strings.newsessionscreen_reset),
            content: Text(strings.newsessionscreen_dialog_reset),
            actions: [
              FlatButton(
                onPressed: () {
                  memberData.startNewSession();
                  Navigator.of(context).pop();
                },
                child: const Text("Okay"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Nein"),
              ),
            ],
          );
        },
      );
    }

    void showKingSelectDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return KingSelectDialog();
        },
      );
    }

    void showSessionOverviewDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return SessionOverviewDialog(
            strafenListe: strafenUiListe,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.darkBackground,
        actions: [
          IconButton(
              icon: Icon(Icons.leaderboard),
              onPressed: () {
                showSessionOverviewDialog();
              }),
          SizedBox(
            width: 5,
          ),
          PopupMenuButton(
            onSelected: (value) {
              if (value == 1) {
                showCustomAlertDialog();
              }
              if (value == 2) {
                showResetAlertDialog();
              }
              if (value == 3) {
                showKingSelectDialog();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(strings.newsessionscreen_popupmenu_save),
                value: 1,
              ),
              PopupMenuItem(
                child: Text(strings.newsessionscreen_popupmenu_reset),
                value: 2,
              ),
              PopupMenuItem(
                child: Text(strings.newsessionscreen_popupmenu_king),
                value: 3,
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
        ],
        title: Text(
          "Kegelabend",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: color.greyText,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: color.darkBackground,
      body: Center(
        child: Column(
          children: [
            NewDropDownMenu(),
            Container(
              color: color.darkBackground,
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: color.blueContainer,
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Container(
                        margin: EdgeInsets.all(5),
                        width: 80,
                        child: Text(
                          strafenUiListe[index],
                          style: TextStyle(color: color.greyText),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.remove_circle,
                                color: color.greyText,
                              ),
                              onPressed: () {
                                setState(() {
                                  memberData.setStrafenLower(
                                      index, strafenUiListe[index]);
                                });
                              }),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: color.greyText,
                            ),
                            child: FutureBuilder(
                              future: memberData
                                  .getStrafenCount(strafenUiListe[index]),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "    " + snapshot.data + "    ",
                                  );
                                } else {
                                  return Text("       ");
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                color: color.greyText,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (strafenUiListe[index] == "Alle Neune") {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Alle Neune wurde für die andere Spieler hinzugefügt",
                                        gravity: ToastGravity.BOTTOM,
                                        toastLength: Toast.LENGTH_SHORT);
                                  }
                                  memberData.setStrafen(
                                      index, strafenUiListe[index]);
                                });
                              }),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: strafenUiListe.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
