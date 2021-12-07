import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:KegelApp/kegelapp_res/kegel_strings.dart';
import 'package:KegelApp/models/session_utils.dart';
import 'package:KegelApp/widgets/SessionScreenWidget.dart';
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

  Future<dynamic> getData() {
    return sessionUtils.returnLastSession();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SessionScreenWidget(snapshot.data);
        }
        if (snapshot.hasData) {
          return SessionScreenWidget(snapshot.data);
        }
      },
    );
  }
}
