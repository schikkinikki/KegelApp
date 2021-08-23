import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:flutter/material.dart';

class StrafenEditScreen extends StatefulWidget {
  static const routeName = "/strafen-edit-screen";

  @override
  _StrafenEditScreenState createState() => _StrafenEditScreenState();
}

class _StrafenEditScreenState extends State<StrafenEditScreen> {
  KegelColor color = new KegelColor();

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
      body: Container(),
    );
  }
}
