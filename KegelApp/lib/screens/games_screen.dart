import 'package:flutter/material.dart';

class GamesScreen extends StatefulWidget {
  static const routeName = "/games-screen";
  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Spiele sind in Arbeit"),
    );
  }
}
