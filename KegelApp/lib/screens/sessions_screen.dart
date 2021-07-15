import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:KegelApp/kegelapp_res/kegel_strings.dart';
import 'package:KegelApp/screens/new_session_screen.dart';
import 'package:KegelApp/screens/old_session_screen_v2.dart';
import 'package:KegelApp/widgets/PresentSelectDialog.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatefulWidget {
  static const routeName = "/session-screen";

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  KegelColor color = new KegelColor();
  KegelStrings strings = new KegelStrings();

  //zum nächsten SessionScreen wechseln
  void switchScreen(var routeName) {
    var screenRoute = routeName;

    switch (screenRoute) {
      case NewSessionScreen.routeName:
        showPresentDialog();
        // Navigator.of(context).pushNamed(NewSessionScreen.routeName);
        break;
      case OldSessionScreenV2.routeName:
        Navigator.of(context).pushNamed(OldSessionScreenV2.routeName);
        break;
      default:
        break;
    }
  }

  void showPresentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return PresentDialog();
      },
    );
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
                color: color.blueContainer,
              ),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  strings.sessionscreen_new_session,
                  style: TextStyle(fontSize: 25, color: color.greyText),
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
                color: color.blueContainer,
              ),
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  strings.sessionscreen_old_sessions,
                  style: TextStyle(fontSize: 25, color: color.greyText),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
