import 'package:KegelApp/models/MembersListClass.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/widgets/DropDownMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewSessionScreen extends StatefulWidget {
  static const routeName = "/new-session-screen";

  @override
  _NewSessionScreenState createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends State<NewSessionScreen> {
  @override
  Widget build(BuildContext context) {
    final memberData = Provider.of<MemberListClass>(context);
    final memberlist = memberData.member;

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
          "Kegelabend",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            DropDownMenu(),
            //TODO map the list of punishment to the itemBuilder
            Container(
              height: 400,
              child: ListView.builder(
                itemBuilder: null,
                itemCount: null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
