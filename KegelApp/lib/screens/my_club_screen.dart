import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/kegelapp_res/kegel_strings.dart';
import 'package:KegelApp/models/MembersListClass.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyClubScreen extends StatefulWidget {
  static const routeName = "/my-club-screen";

  @override
  _MyClubScreenState createState() => _MyClubScreenState();
}

class _MyClubScreenState extends State<MyClubScreen> {
  KegelStrings strings = new KegelStrings();

  //get Textfield input
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  //add Member Dialog
  Future<dynamic> addMember(MemberListClass memberlist) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(strings.myclubscreen_add_member),
            children: [
              SimpleDialogOption(
                child: Column(
                  children: [
                    Text(strings.myclubscreen_add_name),
                    TextField(
                      controller: myController,
                    ),
                    Row(
                      children: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(strings.myclubscreen_stop),
                        ),
                        FlatButton(
                          onPressed: () {
                            Kegelbruder spieler =
                                Kegelbruder(name: myController.text);
                            memberlist.addMember(spieler);
                            DBProvider.db.addKegelbruder(spieler);
                            myController.clear();
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: Text(strings.myclubscreen_add),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<Kegelbruder>>(
          future: DBProvider.db.getAllKegelbruder(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Kegelbruder>> snapshot) {
            final memberData = Provider.of<MemberListClass>(context);
            final memberlist = memberData.member;
            if (snapshot.hasData) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.65 - 5,
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      Kegelbruder player = snapshot.data[index];
                      return Container(
                        padding: EdgeInsets.all(3),
                        width: 350,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(16, 42, 67, 0.7),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.perm_identity,
                                size: 32,
                                color: Color.fromRGBO(217, 226, 236, 1)),
                            Text(
                              player.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(217, 226, 236, 1)),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 32,
                                  color: Color.fromRGBO(217, 226, 236, 1),
                                ),
                                onPressed: () {
                                  DBProvider.db.deleteKegelbruder(player.name);
                                  memberData.deleteMember(player);
                                  setState(() {});
                                }),
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data.length),
              );
            } else {
              return Center(
                child: Text(strings.myclubscreen_no_player),
              );
            }
          },
        ),
        FutureBuilder(
          future: DBProvider.db.getAllKegelbruder(),
          builder: (context, snapshot) {
            final memberData = Provider.of<MemberListClass>(context);
            return SizedBox(
              height: 50,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  addMember(memberData);
                  print(memberData);
                },
                icon: Icon(
                  Icons.person_add,
                  color: Color.fromRGBO(217, 226, 236, 1),
                ),
                label: Text(
                  strings.myclubscreen_add_member,
                  style: TextStyle(color: Color.fromRGBO(217, 226, 236, 0.7)),
                ),
                color: Color.fromRGBO(16, 42, 67, 0.7),
              ),
            );
          },
        ),
      ],
    );
  }
}
