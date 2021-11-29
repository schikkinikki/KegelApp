import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:KegelApp/kegelapp_res/kegel_strings.dart';
import 'package:KegelApp/models/session_utils.dart';
import 'package:KegelApp/screens/PresentSelectScreen.dart';
import 'package:KegelApp/screens/new_session_screen.dart';
import 'package:KegelApp/screens/old_session_screen_v2.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatefulWidget {
  static const routeName = "/session-screen";

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  KegelColor color = new KegelColor();
  KegelStrings strings = new KegelStrings();
  SessionUtils sessionUtils = new SessionUtils();

  //zum nächsten SessionScreen wechseln
  void switchScreen(var routeName) {
    var screenRoute = routeName;

    switch (screenRoute) {
      case NewSessionScreen.routeName:
        Navigator.of(context).pushNamed(PresentSelectScreen.routeName);
        break;
      case OldSessionScreenV2.routeName:
        Navigator.of(context).pushNamed(OldSessionScreenV2.routeName);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => switchScreen(NewSessionScreen.routeName),
                child: Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: color.blueContainer,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.sessionscreen_new_session,
                        style: TextStyle(fontSize: 18, color: color.greyText),
                      ),
                      Icon(Icons.arrow_forward, color: color.greyText),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => switchScreen(OldSessionScreenV2.routeName),
                child: Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: color.blueContainer,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.sessionscreen_old_sessions,
                        style: TextStyle(fontSize: 18, color: color.greyText),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: color.greyText,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Highlights des letzten Abends:",
            style: TextStyle(
              color: color.greyText,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                  height: 100,
                  width: 170,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.blueContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Letzter Kegelkönig:",
                        style: TextStyle(color: color.greyText),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FutureBuilder(
                        future: sessionUtils.returnLastSession(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              sessionUtils.returnKegelkoenig(snapshot.data),
                              style: TextStyle(
                                  color: color.greyText, fontSize: 16),
                            );
                          } else if (!snapshot.hasData) {
                            return Text("Nicht verfügbar");
                          } else if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return CircularProgressIndicator(
                              color: color.greyText,
                            );
                          }
                        },
                      ),
                    ],
                  )),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 100,
                width: 170,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.blueContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      "Letzter Pumpenkönig:",
                      style: TextStyle(
                        color: color.greyText,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FutureBuilder(
                      future: sessionUtils.returnLastSession(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            sessionUtils.returnPumpenkoenig(snapshot.data),
                            style:
                                TextStyle(color: color.greyText, fontSize: 16),
                          );
                        } else if (!snapshot.hasData) {
                          return Text("Nicht verfügbar");
                        } else if (snapshot.connectionState !=
                            ConnectionState.done) {
                          return CircularProgressIndicator(
                              color: color.greyText);
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                height: 100,
                width: 170,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: color.blueContainer,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Text(
                      "Wenigste Pumpen:",
                      style: TextStyle(color: color.greyText),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: sessionUtils.returnLastSession(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                              sessionUtils.returnMinPumpen(snapshot.data),
                              style: TextStyle(color: color.greyText));
                        } else if (!snapshot.hasData) {
                          return Text("Nicht verfügbar");
                        } else if (snapshot.connectionState !=
                            ConnectionState.done) {
                          return CircularProgressIndicator(
                            color: color.greyText,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 100,
                width: 170,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: color.blueContainer,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Text(
                      "Meiste Strafen:",
                      style: TextStyle(color: color.greyText),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: sessionUtils.returnLastSession(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            sessionUtils.returnMaxStrafen(snapshot.data),
                            style: TextStyle(color: color.greyText),
                          );
                        } else if (!snapshot.hasData) {
                          return Text("Nicht verfügbar");
                        } else if (snapshot.connectionState !=
                            ConnectionState.done) {
                          return CircularProgressIndicator(
                            color: color.greyText,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
