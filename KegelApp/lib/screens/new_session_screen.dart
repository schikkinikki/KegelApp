import 'package:KegelApp/models/MembersListClass.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:KegelApp/widgets/DropDownMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewSessionScreen extends StatelessWidget {
  static const routeName = "/new-session-screen";

  @override
  Widget build(BuildContext context) {
    final memberData = Provider.of<MemberListClass>(context);
    final memberlist = memberData.member;
    // Kegelbruder dropPlayer = memberlist[0];

    // List<String> strafenList = [
    //   "Pumpe",
    //   "Durchwurf",
    //   "Klingeln",
    //   "Stina",
    //   "Kugel bringen",
    //   "Handy"
    // ];

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
            // DropDownMenu(),
            // DropdownButton(
            //     value: dropPlayer,
            //     items: memberlist
            //         .map<DropdownMenuItem<Kegelbruder>>((Kegelbruder spieler) {
            //       return DropdownMenuItem(
            //         value: spieler,
            //         child: Text(spieler.name),
            //       );
            //     }).toList(),
            //     onChanged: (Kegelbruder player) {
            //       memberData.changeSelection(player);
            //       print(player.isSelected);
            //       dropPlayer = player;
            //     }),
          ],
        ),
      ),
    );
  }
}
