import 'package:flutter/material.dart';

class OldSessionScreen extends StatelessWidget {
  static const routeName = "/old-session-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange, Colors.red],
            ),
          ),
        ),
        title: Text(
          "Kegel App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Text("Alte Session kommen hier hin!"),
      ),
    );
  }
}
