import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/models/MembersListClass.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/models/session.dart';
import 'package:KegelApp/widgets/NewDropDownMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NewSessionScreen extends StatefulWidget {
  static const routeName = "/new-session-screen";

  @override
  _NewSessionScreenState createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends State<NewSessionScreen> {
  @override
  Widget build(BuildContext context) {
    final memberData = Provider.of<MemberListClass>(context);
    final List<String> strafenUiListe = [
      "Pumpe",
      "Klingeln",
      "Stina",
      "Durchwurf",
      "Handy",
      "Kugel bringen",
      "Zu 2. auf der Bahn",
      "Lustwurf"
    ];

    void saveAndResetSession() async {
      var date = DateFormat.yMd();
      var dateString = date.format(DateTime.now());

      List<Kegelbruder> list = await DBProvider.db.getAllKegelbruder();
      list.forEach((member) async {
        var session = new Session(date: dateString, kegelbruder: member);
        await DBProvider.db.addSession(session);
        print("session with " + member.name + "was added");
      });
    }

    void showCustomAlertDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Speichern und beenden"),
            content: const Text(
                "Möchtest du wirklich den laufenden Abend speichern und beenden? Alle Einträge werden dabei auf null zurückgesetzt!"),
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
            title: const Text("Kegelabend zurücksetzen?"),
            content: const Text(
                "Möchtest du wirklich den laufenden Abend zurücksetzen?"),
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(48, 48, 48, 1),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 1) {
                showCustomAlertDialog();
              }
              if (value == 2) {
                showResetAlertDialog();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Kegelabend beenden"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Kegelabend zurücksetzen"),
                value: 2,
              )
            ],
            icon: Icon(Icons.more_vert),
          )
        ],
        title: Text(
          "Kegelabend",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color.fromRGBO(217, 226, 236, 1),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(48, 48, 48, 1),
      body: Center(
        child: Column(
          children: [
            NewDropDownMenu(),
            Container(
              color: Color.fromRGBO(48, 48, 48, 1),
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Color.fromRGBO(16, 42, 67, 0.7),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Container(
                        margin: EdgeInsets.all(5),
                        width: 80,
                        child: Text(
                          strafenUiListe[index],
                          style: TextStyle(
                              fontSize: 17,
                              color: Color.fromRGBO(217, 226, 236, 1)),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                color: Color.fromRGBO(217, 226, 236, 1),
                              ),
                              onPressed: () {
                                setState(() {
                                  memberData.setStrafen(
                                      index, strafenUiListe[index]);
                                });
                              }),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Color.fromRGBO(217, 226, 236, 1),
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
                                Icons.remove_circle,
                                color: Color.fromRGBO(217, 226, 236, 1),
                              ),
                              onPressed: () {
                                setState(() {
                                  memberData.setStrafenLower(
                                      index, strafenUiListe[index]);
                                });
                              })
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
