import 'package:KegelApp/screens/new_session_screen.dart';
import 'package:KegelApp/screens/old_session_screen.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatefulWidget {
  static const routeName = "/session-screen";

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  //zum nächsten SessionScreen wechseln
  void switchScreen(var routeName) {
    var screenRoute = routeName;

    switch (screenRoute) {
      case NewSessionScreen.routeName:
        Navigator.of(context).pushNamed(NewSessionScreen.routeName);
        break;
      case OldSessionScreen.routeName:
        Navigator.of(context).pushNamed(OldSessionScreen.routeName);
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.red, Colors.deepOrange],
                ),
              ),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Text(
                "Neue Session",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => switchScreen(OldSessionScreen.routeName),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.red, Colors.deepOrange],
                ),
              ),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Text(
                "Vergangene Sessions",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
