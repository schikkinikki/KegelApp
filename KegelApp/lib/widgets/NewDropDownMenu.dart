import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:KegelApp/models/kegelbruder.dart';
import 'package:flutter/material.dart';

class NewDropDownMenu extends StatefulWidget {
  @override
  _NewDropDownMenuState createState() => _NewDropDownMenuState();
}

String dropDownValue;

class _NewDropDownMenuState extends State<NewDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    // change selection value based on the given name from the DropDownButton
    void changeSelection(String name) async {
      List<Kegelbruder> allPlayer = await DBProvider.db.getAllKegelbruder();

      allPlayer.forEach((player) async {
        if (player.name == name) {
          player.setSelected();
          await DBProvider.db.updateKegelbruder(player);
          print(player.name + player.isSelected.toString());
        } else if (player.name != name) {
          player.isSelected = 0;
          await DBProvider.db.updateKegelbruder(player);
          print(player.name + player.isSelected.toString());
        }
      });
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
                  changeSelection(newValue);
                });
              });
        } else {
          return Text("Keine Spieler verfügbar");
        }
      },
    );
  }
}
