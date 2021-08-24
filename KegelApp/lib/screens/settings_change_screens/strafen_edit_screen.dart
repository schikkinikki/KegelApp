import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:KegelApp/models/strafe.dart';
import 'package:flutter/material.dart';

class StrafenEditScreen extends StatefulWidget {
  static const routeName = "/strafen-edit-screen";

  @override
  _StrafenEditScreenState createState() => _StrafenEditScreenState();
}

class _StrafenEditScreenState extends State<StrafenEditScreen> {
  KegelColor color = new KegelColor();
  final myController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  void showEditDialog(BuildContext mContext, String newStrafenName) {
    showModalBottomSheet(
      context: mContext,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setBottomState) {
            return Container(
              height: 300,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Neuen Namen für " + newStrafenName + " eingeben:",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: myController,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Strafenhöhe ändern",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: color.greyText),
        ),
        centerTitle: true,
        backgroundColor: color.darkBackground,
      ),
      body: Container(
        color: color.darkBackground,
        child: FutureBuilder(
          future: DBProvider.db.getAllStrafen(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Keine Strafen vorhanden!"),
              );
            }
            if (snapshot.hasData) {
              List<Strafe> strafenListe = snapshot.data;
              return ListView.builder(
                itemCount: strafenListe.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: color.blueContainer,
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            strafenListe[index].strafenName,
                            style:
                                TextStyle(fontSize: 25, color: color.greyText),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: color.greyText,
                              ),
                              onPressed: () {
                                showEditDialog(
                                    context, strafenListe[index].strafenName);
                              })
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
