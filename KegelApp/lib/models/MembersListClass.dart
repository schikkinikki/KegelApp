import 'package:KegelApp/database/kegelAppDatabase.dart';
import 'package:flutter/cupertino.dart';

import 'kegelbruder.dart';
import 'package:flutter/foundation.dart';

class MemberListClass extends ChangeNotifier {
  List<Kegelbruder> memberlist = [];

  List<Kegelbruder> get member {
    return [...memberlist];
  }

  void addMember(Kegelbruder member) {
    memberlist.add(member);
    notifyListeners();
  }

  void deleteMember(Kegelbruder member) {
    memberlist.removeWhere((element) => element.name == member.name);
    notifyListeners();
  }

  List<String> getPlayerNames() {
    List<String> playerNames = [];
    memberlist.forEach((player) {
      playerNames.add(player.name);
    });
    return playerNames;
  }

  Kegelbruder getOnePlayer(String name) {
    return memberlist.firstWhere((element) => element.name == name);
  }

  // void setStrafen(int index, String strafen) {
  //   memberlist.forEach((player) {
  //     List<int> strafenliste = player.strafenListen;
  //     while (player.isSelected == 1) {
  //       switch (strafen) {
  //         case "Pumpe":
  //           strafenliste[index]++;
  //           player.setPumpe(strafenliste[index]);
  //           print(player.name + player.pumpen.toString());
  //           break;
  //         case "Klingeln":
  //           strafenliste[index]++;
  //           player.setKlingeln(strafenliste[index]);
  //           break;
  //         case "Stina":
  //           strafenliste[index]++;
  //           player.setMittenDurch(strafenliste[index]);
  //           break;
  //         case "Durchwurf":
  //           strafenliste[index]++;
  //           player.setDurchWurf(strafenliste[index]);
  //           break;
  //         case "Handy":
  //           strafenliste[index]++;
  //           player.setHandy(strafenliste[index]);
  //           break;
  //         case "Kugel bringen":
  //           strafenliste[index]++;
  //           player.setKugelBringen(strafenliste[index]);
  //           break;
  //         case "Zu 2. auf der Bahn":
  //           strafenliste[index]++;
  //           player.setZuZweitaufDerBahn(strafenliste[index]);
  //           break;
  //         case "Lustwurf":
  //           strafenliste[index]++;
  //           player.setLustwurf(strafenliste[index]);
  //           break;
  //         default:
  //           break;
  //       }
  //       return;
  //     }
  //   });
  //   notifyListeners();
  // }

  void setStrafenLower(int index, String strafen) {
    memberlist.forEach((player) {
      List<int> strafenliste = player.strafenListen;
      while (player.isSelected == 1) {
        switch (strafen) {
          case "Pumpe":
            strafenliste[index]--;
            player.setPumpe(strafenliste[index]);
            print(player.name + player.pumpen.toString());
            break;
          case "Klingeln":
            strafenliste[index]--;
            player.setKlingeln(strafenliste[index]);
            break;
          case "Stina":
            strafenliste[index]--;
            player.setMittenDurch(strafenliste[index]);
            break;
          case "Durchwurf":
            strafenliste[index]--;
            player.setDurchWurf(strafenliste[index]);
            break;
          case "Handy":
            strafenliste[index]--;
            player.setHandy(strafenliste[index]);
            break;
          case "Kugel bringen":
            strafenliste[index]--;
            player.setKugelBringen(strafenliste[index]);
            break;
          case "Zu 2. auf der Bahn":
            strafenliste[index]--;
            player.setZuZweitaufDerBahn(strafenliste[index]);
            break;
          case "Lustwurf":
            strafenliste[index]--;
            player.setLustwurf(strafenliste[index]);
            break;
          default:
            break;
        }
        return;
      }
    });
    notifyListeners();
  }

  int getOneStrafe(int index) {
    Kegelbruder player = memberlist.firstWhere(
        (element) => element.isSelected == 1,
        orElse: () => new Kegelbruder(name: null));
    return player.getSingleStrafe(index);
  }

// set Strafen for selected Player
  void setStrafen(int index, String strafen) async {
    // get all Kegelbruder from DB
    List<Kegelbruder> kegelbruderListe =
        await DBProvider.db.getAllKegelbruder();

    // get strafenliste from kegelbruder an loop through until he is // no longer selected
    kegelbruderListe.forEach((kegelbruder) {
      List<int> strafenListe = kegelbruder.strafenListen;
      while (kegelbruder.isSelected == 1) {
        switch (strafen) {
          case "Pumpe":
            strafenListe[index]++;
            kegelbruder.setPumpe(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Klingeln":
            strafenListe[index]++;
            kegelbruder.setKlingeln(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Stina":
            strafenListe[index]++;
          // TODO finish logic here
        }
        return;
      }
    });
  }
}
