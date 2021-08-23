import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:KegelApp/models/strafe.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class StrafenhoeheScreen extends StatefulWidget {
  static const routeName = "/strafenhoehe-screen";

  @override
  _StrafenhoeheScreenState createState() => _StrafenhoeheScreenState();
}

class _StrafenhoeheScreenState extends State<StrafenhoeheScreen> {
  KegelColor color = new KegelColor();
  double newStrafenValue;

  void showChangeStrafenHoeheDialog(
      BuildContext mContext, double newStrafenValue, String newStrafenName) {
    showBottomSheet(
      context: mContext,
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Neuen Wert für " + newStrafenName + " eingeben:",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        onPressed: () {},
                        child: Text("-0,1"),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        onPressed: () {},
                        child: Text("-0,5"),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        onPressed: () {},
                        child: Text("-1,0"),
                      ),
                    ],
                  ),
                  Text(
                    newStrafenValue.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  Column(
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        onPressed: () {},
                        child: Text("+0,1"),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        onPressed: () {},
                        child: Text("+0,5"),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        onPressed: () {},
                        child: Text("+1,0"),
                      ),
                    ],
                  ),
                ],
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Okay"),
              )
            ],
          ),
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
                child: Text("Keine Strafen gefunden!"),
              );
            }
            if (snapshot.hasData) {
              List<Strafe> strafenListe = snapshot.data;
              return ListView.builder(
                itemCount: strafenListe.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      newStrafenValue = strafenListe[index].strafenHoehe;
                      showChangeStrafenHoeheDialog(context, newStrafenValue,
                          strafenListe[index].strafenName);
                    },
                    child: Card(
                      color: color.blueContainer,
                      margin: EdgeInsets.all(5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              strafenListe[index].strafenName,
                              style: TextStyle(
                                  fontSize: 25, color: color.greyText),
                            ),
                            Icon(
                              Icons.edit,
                              color: color.greyText,
                            ),
                          ],
                        ),
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
