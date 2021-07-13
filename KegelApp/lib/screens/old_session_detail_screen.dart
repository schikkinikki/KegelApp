import 'package:KegelApp/kegelapp_res/kegel_colors.dart';
import 'package:KegelApp/widgets/DataTableWidget.dart';
import 'package:flutter/material.dart';

class OldSessionDetailScreen extends StatefulWidget {
  static const routeName = "/old-session-detail-screen";
  @override
  _OldSessionDetailScreenState createState() => _OldSessionDetailScreenState();
}

class _OldSessionDetailScreenState extends State<OldSessionDetailScreen> {
  KegelColor color = new KegelColor();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.darkBackground,
        title: Text(
          "Details",
          style: TextStyle(fontSize: 30, color: color.greyText),
        ),
        centerTitle: true,
      ),
      body: DataTableWidget(args),
    );
  }
}
