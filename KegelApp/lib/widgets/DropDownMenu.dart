import 'package:KegelApp/models/MembersListClass.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownMenu extends StatefulWidget {
  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    final memberData = Provider.of<MemberListClass>(context);
    final memberlist = memberData.member;
    Kegelbruder dropPlayer = memberlist[0];

    return DropdownButton(
        value: memberData.getPlayer(dropPlayer),
        items:
            memberlist.map<DropdownMenuItem<Kegelbruder>>((Kegelbruder player) {
          return DropdownMenuItem(
            value: player,
            child: Text(player.name),
          );
        }).toList(),
        onChanged: (Kegelbruder player) {
          dropPlayer = player;
          memberData.changeSelection(player);
          print(player.name + player.isSelected.toString());
        });
  }
}
