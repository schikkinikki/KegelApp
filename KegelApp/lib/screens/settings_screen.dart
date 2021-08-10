import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:KegelApp/screens/settings_change_screens/strafenhoehe_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settingsScreen";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  KegelColor color = new KegelColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.darkBackground,
        title: Text(
          "Einstellungen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: color.greyText,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: color.darkBackground,
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(StrafenhoeheScreen.routeName);
            },
            child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: color.greyText),
                  borderRadius: BorderRadius.circular(10),
                  color: color.blueContainer),
              child: Text(
                "Strafenhöhe ändern",
                style: TextStyle(fontSize: 20, color: color.greyText),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
