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

  int getOneStrafe(int index) {
    Kegelbruder player = memberlist.firstWhere(
        (element) => element.isSelected == 1,
        orElse: () => new Kegelbruder(name: null));
    return player.getSingleStrafe(index);
  }

// set Strafen for selected Player higher
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
            kegelbruder.setMittenDurch(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Durchwurf":
            strafenListe[index]++;
            kegelbruder.setDurchWurf(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Handy":
            strafenListe[index]++;
            kegelbruder.setHandy(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Kugel bringen":
            strafenListe[index]++;
            kegelbruder.setKugelBringen(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Zu 2. auf der Bahn":
            strafenListe[index]++;
            kegelbruder.setZuZweitaufDerBahn(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Lustwurf":
            strafenListe[index]++;
            kegelbruder.setLustwurf(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          default:
            break;
        }
        return;
      }
      notifyListeners();
    });
  }

  // set Strafen for selected Player lower
  void setStrafenLower(int index, String strafen) async {
    // get all Kegelbruder from DB
    List<Kegelbruder> kegelbruderListe =
        await DBProvider.db.getAllKegelbruder();

    // get strafenliste from kegelbruder an loop through until he is // no longer selected
    kegelbruderListe.forEach((kegelbruder) {
      List<int> strafenListe = kegelbruder.strafenListen;
      while (kegelbruder.isSelected == 1) {
        switch (strafen) {
          case "Pumpe":
            strafenListe[index]--;
            kegelbruder.setPumpe(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Klingeln":
            strafenListe[index]--;
            kegelbruder.setKlingeln(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Stina":
            strafenListe[index]--;
            kegelbruder.setMittenDurch(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Durchwurf":
            strafenListe[index]--;
            kegelbruder.setDurchWurf(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Handy":
            strafenListe[index]--;
            kegelbruder.setHandy(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Kugel bringen":
            strafenListe[index]--;
            kegelbruder.setKugelBringen(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Zu 2. auf der Bahn":
            strafenListe[index]--;
            kegelbruder.setZuZweitaufDerBahn(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          case "Lustwurf":
            strafenListe[index]--;
            kegelbruder.setLustwurf(strafenListe[index]);
            DBProvider.db.updateKegelbruder(kegelbruder);
            break;
          default:
            break;
        }
        return;
      }
      notifyListeners();
    });
  }
}
