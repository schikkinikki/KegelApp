import 'dart:developer';

import 'package:KegelApp/models/MembersListClass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownMenu extends StatefulWidget {
  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

String dropDownValue;

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    final memberData = Provider.of<MemberListClass>(context);
    final memberlist = memberData.member;
    final memberNames = memberData.getPlayerNames();

    return DropdownButton(
      value: dropDownValue,
      items: memberNames.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem(
            child: Text(value),
            value: value,
          );
        },
      ).toList(),
      onChanged: (String newValue) {
        setState(() {
          dropDownValue = newValue;
        });
      },
    );
  }
}
