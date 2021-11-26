import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/models/MembersListClass.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:flutter/material.dart';

class SessionOverviewDialog extends StatefulWidget {
  final List<String> strafenListe;

  SessionOverviewDialog({this.strafenListe});
  @override
  _SessionOverviewDialogState createState() => _SessionOverviewDialogState();
}

class _SessionOverviewDialogState extends State<SessionOverviewDialog> {
  String displayedText = "Pumpe";

  @override
  Widget build(BuildContext context) {
    final String backButtonKey = "BACK_BUTTON";
    final String forwardButtonKey = "FORWARD_BUTTON";
    MemberListClass memberListClass = new MemberListClass();

    void changeStrafe(List<String> strafenListe, String key, String text) {
      int index = strafenListe.indexOf(text);
      if (key == backButtonKey) {
        if (index != 0) {
          index -= 1;
        } else {
          index = strafenListe.length - 1;
        }
        setState(() {
          displayedText = strafenListe[index];
        });
      } else if (key == forwardButtonKey) {
        if (index != strafenListe.length - 1) {
          index += 1;
        } else {
          index = 0;
        }
        setState(() {
          displayedText = strafenListe[index];
        });
      }
      print(displayedText);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        height: 550,
        width: 350,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    changeStrafe(
                        widget.strafenListe, backButtonKey, displayedText);
                  },
                  key: Key(backButtonKey),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(displayedText),
                SizedBox(
                  width: 17,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      changeStrafe(
                          widget.strafenListe, forwardButtonKey, displayedText);
                    });
                  },
                  key: Key(forwardButtonKey),
                ),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  iconSize: 28,
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              height: 500,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FutureBuilder(
                future: DBProvider.db.getAllKegelbruder(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Keine Daten vorhanden"),
                    );
                  }
                  List<Kegelbruder> kegelbruderListe = snapshot.data;
                  return ListView.builder(
                    itemCount: kegelbruderListe.length,
                    itemBuilder: (context, index) {
                      var sortedList =
                          memberListClass.sortListeforScreenOverview(
                              displayedText, kegelbruderListe);
                      return Container(
                        padding: EdgeInsets.only(left: 5, top: 10),
                        child: memberListClass.createBars(
                            displayedText, sortedList, kegelbruderListe[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
