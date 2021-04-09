import 'package:KegelApp/models/MembersListClass.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/widgets/DropDownMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewSessionScreen extends StatefulWidget {
  static const routeName = "/new-session-screen";

  @override
  _NewSessionScreenState createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends State<NewSessionScreen> {
  @override
  Widget build(BuildContext context) {
    final memberData = Provider.of<MemberListClass>(context);
    final memberlist = memberData.member;
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

    var strafenCounter = 0;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange, Colors.red],
            ),
          ),
        ),
        title: Text(
          "Kegelabend",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            DropDownMenu(),
            Container(
              height: 500,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Container(
                        margin: EdgeInsets.all(5),
                        width: 80,
                        child: Text(
                          strafenUiListe[index],
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(Icons.add_circle),
                              onPressed: () => strafenCounter++),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Text("      " +
                                strafenCounter.toString() +
                                "      "),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () => strafenCounter--)
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
