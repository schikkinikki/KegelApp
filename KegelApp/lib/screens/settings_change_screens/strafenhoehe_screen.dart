import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:flutter/material.dart';

class StrafenhoeheScreen extends StatefulWidget {
  static const routeName = "/strafenhoehe-screen";

  @override
  _StrafenhoeheScreenState createState() => _StrafenhoeheScreenState();
}

class _StrafenhoeheScreenState extends State<StrafenhoeheScreen> {
  KegelColor color = new KegelColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Strafenhöhe ändern",
          style: TextStyle(color: color.greyText),
        ),
        centerTitle: true,
        backgroundColor: color.darkBackground,
      ),
      body: Container(
        child: Center(
          child: Text("Strafenhöhe ändern"),
        ),
      ),
    );
  }
}
