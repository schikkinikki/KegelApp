import 'package:KegelApp/widgets/DataTableWidget.dart';
import 'package:flutter/material.dart';

class OldSessionDetailScreen extends StatefulWidget {
  static const routeName = "/old-session-detail-screen";
  @override
  _OldSessionDetailScreenState createState() => _OldSessionDetailScreenState();
}

class _OldSessionDetailScreenState extends State<OldSessionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(48, 48, 48, 1),
        title: Text(
          "Details",
          style:
              TextStyle(fontSize: 30, color: Color.fromRGBO(217, 226, 236, 1)),
        ),
        centerTitle: true,
      ),
      body: DataTableWidget(args),
    );
  }
}
