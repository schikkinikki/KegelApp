import 'package:KegelApp/kegelapp_res/kegel_strings.dart';
import 'package:KegelApp/screens/new_session_screen.dart';
import 'package:KegelApp/screens/old_session_screen_v2.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatefulWidget {
  static const routeName = "/session-screen";

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  KegelStrings strings = new KegelStrings();

  //zum nächsten SessionScreen wechseln
  void switchScreen(var routeName) {
    var screenRoute = routeName;

    switch (screenRoute) {
      case NewSessionScreen.routeName:
        Navigator.of(context).pushNamed(NewSessionScreen.routeName);
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => switchScreen(NewSessionScreen.routeName),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(16, 42, 67, 0.7),
              ),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  strings.sessionscreen_new_session,
                  style: TextStyle(
                      fontSize: 25, color: Color.fromRGBO(217, 226, 236, 1)),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => switchScreen(OldSessionScreenV2.routeName),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(16, 42, 67, 0.7),
              ),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  strings.sessionscreen_old_sessions,
                  style: TextStyle(
                      fontSize: 25, color: Color.fromRGBO(217, 226, 236, 1)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
