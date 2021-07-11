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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange, Colors.red],
            ),
          ),
        ),
        title: Text("Details"),
        centerTitle: true,
      ),
      body: DataTableWidget(args),
    );
  }
}
