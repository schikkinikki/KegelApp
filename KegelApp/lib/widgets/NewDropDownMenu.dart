import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/models/MembersListClass.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewDropDownMenu extends StatefulWidget {
  @override
  _NewDropDownMenuState createState() => _NewDropDownMenuState();
}

String dropDownValue;

class _NewDropDownMenuState extends State<NewDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    final memberData = Provider.of<MemberListClass>(context);
    final memberlist = memberData.member;

    Kegelbruder getSelectedPlayer(String name) {
      memberlist.forEach((element) {
        if (element.name == name) {
          element.setSelected();
        }
        if (element.name != name) {
          element.isSelected = 0;
        }
        print(element.name + element.isSelected.toString());
      });
    }

    void changeSelection(String name) async {
      Kegelbruder selectedPlayer = await DBProvider.db.getKegelbruder(name);
      selectedPlayer.setSelected();
      await DBProvider.db.updateKegelbruder(selectedPlayer);
      print(selectedPlayer.isSelected.toString());
    }

    return FutureBuilder<List<Kegelbruder>>(
      future: DBProvider.db.getAllKegelbruder(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton(
              value: dropDownValue,
              items: snapshot.data
                  .map(
                    (kb) => DropdownMenuItem<String>(
                      child: Text(kb.name),
                      value: kb.name,
                    ),
                  )
                  .toList(),
              onChanged: (String newValue) {
                setState(() {
                  dropDownValue = newValue;
                  print(newValue);
                  changeSelection(dropDownValue);
                });
              });
        } else {
          return Text("Keine Spieler verfügbar");
        }
      },
    );
  }
}
